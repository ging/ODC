# encoding: utf-8

namespace :rs do

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

  #Development: bundle exec rake rs:rebuild
  #Production: bundle exec rake rs:rebuild RAILS_ENV=production
  task :rebuild => :environment do |t, args|
    puts "Updating similarity scores used by the recommender system"

    Rake::Task["rs:resetRecommendations"].invoke

    Course.all.each do |cA|
      Course.where("id > ?", cA.id).each do |cB|
        similarityScore = RecommenderSystem.calculateCourseSimilarity(cA,cB,{})
        CourseSimilarity.create! :course_a_id => cA.id,
        :course_b_id => cB.id,
        :value => similarityScore
      end
    end

  end

  #Development: bundle exec rake rs:resetRecommendations
  #Production: bundle exec rake rs:resetRecommendations RAILS_ENV=production
  task :resetRecommendations => :environment do |t, args|
    puts "Removing similarity scores used by the recommender system"
    CourseSimilarity.destroy_all
  end

end