# encoding: utf-8

namespace :rs do

  #Development: bundle exec rake rs:rebuild
  #Production: bundle exec rake rs:rebuild RAILS_ENV=production
  task :rebuild => :environment do |t, args|
    puts "Rebuild data used by the recommender system"

    Setting.rs_date = nil
    Rake::Task["rs:removeRecommendationData"].invoke
    Rake::Task["rs:updateWordsFrequency"].invoke
    Rake::Task["rs:update"].invoke

    puts "Rebuild task finished"
  end

  #Development: bundle exec rake rs:update
  #Production: bundle exec rake rs:update RAILS_ENV=production
  task :update => :environment do |t, args|
    puts "Updating data used by the recommender system"
    
    Setting.rs_date = Time.new(2000, 1, 1) if Setting.rs_date.nil?

    Rake::Task["rs:update_course_recommendations"].invoke
    Rake::Task["rs:update_user_recommendations"].invoke

    Setting.rs_date = Time.current

    puts "Update finished"
  end

  #bundle exec rake rs:update_course_recommendations
  task :update_course_recommendations => :environment do |t, args|
    puts "Updating course similarity scores used by the recommender system"

    Course.all.each do |cA|
      Course.where("id > ? AND updated_at >= ?", cA.id, Setting.rs_date).each do |cB|
        csRecord = CourseSimilarity.where(:course_a_id => cA.id, :course_b_id => cB.id).first
        csRecord = CourseSimilarity.new(:course_a_id => cA.id, :course_b_id => cB.id, :same_course_type => (cA.webinar == cB.webinar)) if csRecord.nil?
        csRecord.value = RecommenderSystem.calculateCourseSimilarity(cA,cB,{})
        csRecord.save!
      end
    end

    Course.all.each do |c|
      csRecords = CourseSimilarity.where("(course_similarities.course_a_id = ? OR course_similarities.course_b_id = ?) AND course_similarities.value > ? AND course_similarities.same_course_type = true", c.id, c.id, 0).order("value DESC").first(50)
      suggestions = csRecords.map{|cs| {:id => [cs.course_a_id,cs.course_b_id].reject{|id| id == c.id}.first, :score => cs.value.to_f}}.sort_by{|r| -r[:score]}
      c.update_column(:suggestions, suggestions)
    end
  end

  #bundle exec rake rs:update_user_recommendations
  task :update_user_recommendations => :environment do |t, args|
    puts "Updating courses suggested to users by the recommender system"

    User.where("updated_at >= ? OR last_sign_in_at >= ? OR course_suggestions IS NULL OR webinar_suggestions IS NULL", Setting.rs_date, (Time.current - 2.days)).each do |u|
      return if (u.tag_list.blank? and u.courses.length == 0)

      candidates = Course.where("courses.id NOT IN (?) AND courses.card_lang = ?", ([-1] + u.courses.map{|u| u.id}), u.ui_language)
      candidateCourses = candidates.where("courses.webinar = false")
      candidateWebinars = candidates.where("courses.webinar = true")

      courseSuggestions = candidateCourses.map{ |c| 
        {:id => c.id, :score => RecommenderSystem.calculateCourseRelevanceForUser(c,u,{})}
      }.reject{|r| r[:score] == 0}.sort_by{|r| -r[:score]}.first(50)
      
      webinarSuggestions = candidateWebinars.map{ |c| 
        {:id => c.id, :score => RecommenderSystem.calculateCourseRelevanceForUser(c,u,{})}
      }.reject{|r| r[:score] == 0}.sort_by{|r| -r[:score]}.first(50)

      u.update_column(:course_suggestions, courseSuggestions)
      u.update_column(:webinar_suggestions, webinarSuggestions)
    end
  end

  #bundle exec rake rs:removeRecommendationData
  task :removeRecommendationData => :environment do |t, args|
    puts "Removing data used by the recommender system"

    CourseSimilarity.destroy_all
    Course.where("courses.suggestions IS NOT NULL").each do |c|
      c.update_column(:suggestions, nil)
    end
    User.where("users.course_suggestions IS NOT NULL or users.webinar_suggestions IS NOT NULL").each do |u|
      u.update_column(:course_suggestions, nil)
      u.update_column(:webinar_suggestions, nil)
    end
  end

  #Development: bundle exec rake rs:updateWordsFrequency
  #Production: bundle exec rake rs:updateWordsFrequency RAILS_ENV=production
  task :updateWordsFrequency => :environment do |t, args|
    puts "Updating Words Frequency (for calculating TF-IDF)"

    #1. Remove previous records
    Word.destroy_all

    #2. Retrieve words from database
    Course.all.each do |c|
      text = ""
      text += " " + RecommenderSystem.processText(c.name) unless c.name.blank?
      text += " " + RecommenderSystem.processText(c.description) unless c.description.blank?
      text += " " + RecommenderSystem.processText(c.lessons_text) unless c.lessons_text.blank?
      saveWordsForText(text)
    end

    #3. Add stopwords
    # For stopwords, the occurences of the word record is set to the 'Course.count' value.
    # This way, the IDF value for these words will be close to 0, and therefore the TF-IDF value will be close to 0 too.
    # Stop words are readed from the file stopwords.yml
    stopwords = File.read("config/stopwords.yml").split(",").map{|s| s.gsub("\n","").gsub("\"","") } rescue []
    stopwords.each do |stopword|
      wordRecord = Word.find_by_value(stopword)
      if wordRecord.nil?
        wordRecord = Word.new
        wordRecord.value = stopword
      end
      wordRecord.occurrences = ODC::Application::config.rs_total_entries
      wordRecord.save!
    end
    
    puts "Task finished"
  end

  def saveWordsForText(text)
    return if text.blank? or !text.is_a? String
    RecommenderSystem.getWordsFromText(text).each do |word,occurrences|
      wordRecord = Word.find_by_value(word)
      if wordRecord.nil?
        wordRecord = Word.new
        wordRecord.value = word
      end
      wordRecord.occurrences += 1
      wordRecord.save! rescue nil #This can be raised for too long words (e.g. long urls)
    end
  end

end