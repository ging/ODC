# encoding: utf-8

class RecommenderSystem

  #API methods
  def self.getRecommendCourses(c,n=4,idsToReject=[])
    suggestions = getSimilarCoursesFromDb(c,n,idsToReject)
    suggestions = getSimilarCoursesInRealTime(c,n,idsToReject) if suggestions.blank?
    return fillCourseSuggestions(suggestions,c,n)
  end

  def self.getRecommendCoursesForUser(u,n=4)
    suggestions = getRecommendCoursesForUserFromDb(u,n)
    suggestions = getRecommendCoursesForUserInRealTime(u,n) if suggestions.blank?
    return fillCourseSuggestionsForUser(suggestions,u,n)
  end

  def self.getRecommendWebinarsForUser(u,n=4)
    suggestions = getRecommendCoursesForUserFromDb(u,n,[],true)
    suggestions = getRecommendCoursesForUserInRealTime(u,n,true) if suggestions.blank?
    return fillCourseSuggestionsForUser(suggestions,u,n,true)
  end


  #Auxiliary methods

  def self.getSimilarCoursesFromDb(c,n=10,idsToReject=[])
    sIds = c.suggestions
    return [] if sIds.blank?
    sIds = sIds.reject{|s| idsToReject.include?(s[:id])} unless idsToReject.blank?
    Course.find(sIds.map{|s| s[:id]}).first(2*n).sample(n)
  end

  def self.getSimilarCoursesInRealTime(c,n=10,idsToReject=[])
    idsToReject = (idsToReject + [c.id]).uniq
    preSelection = Course.where("courses.webinar = ? AND courses.card_lang = ? AND courses.id NOT IN (?)", c.webinar, c.card_lang, idsToReject)
    unless c.categories.blank?
      categoryPreSelection = preSelection.where("categories is NOT NULL").select{|rc| (rc.categories & c.categories).length > 0}
      preSelection = categoryPreSelection if categoryPreSelection.length > 0
    end
    preSelection = preSelection.sample(50).sort_by{ |candidate| -self.calculateCourseSimilarity(c,candidate,{:fast => true}) }.first(n).sample(n) if (n < 50 and preSelection.length > n)
    return preSelection
  end

  def self.getRecommendCoursesForUserFromDb(u,n=10,idsToReject=[],webinar=false)
    sIds = ((webinar == false) ? u.course_suggestions : u.webinar_suggestions)
    return [] if sIds.blank?
    sIds = sIds.reject{|s| idsToReject.include?(s[:id])} unless idsToReject.blank?
    Course.find(sIds.map{|s| s[:id]}).first(2*n).sample(n)
  end

  def self.getRecommendCoursesForUserInRealTime(u,n=10,webinar=false)
    userCourses = u.courses.where(:webinar => webinar)
    return getRecommendCourses(userCourses.sample(1).first,n,userCourses.map{|c| c.id}) if userCourses.length > 0
    return Course.where("courses.card_lang = ? AND webinar = ?", u.ui_language, webinar).sample(n)
  end

  def self.fillCourseSuggestions(suggestions,c,n)
    sL = suggestions.length
    return suggestions unless sL < n
    idsToReject = (suggestions.map{|c| c.id} + [c.id])
    return suggestions + Course.where("courses.id NOT IN (?) AND courses.card_lang = ? AND courses.webinar = ?", idsToReject, c.locale, c.webinar).sample(n - sL)
  end

  def self.fillCourseSuggestionsForUser(suggestions,u,n,webinar=false)
    sL = suggestions.length
    return suggestions unless sL < n
    idsToReject = (suggestions.map{|c| c.id} + u.courses.map{|c| c.id})
    return suggestions + Course.where("courses.id NOT IN (?) AND courses.card_lang = ? AND courses.webinar = ?", idsToReject, u.ui_language, webinar).sample(n - sL)
  end


  #Metrics

  def self.calculateCourseSimilarity(courseA, courseB, options={})
    #Filters
    languageS = self.getSemanticDistanceForCategoricalFields(courseA.locale,courseB.locale)
    typeS = self.getSemanticDistanceForCategoricalFields(courseA.webinar.to_s,courseB.webinar.to_s)
    return 0 if languageS == 0 or typeS == 0

    weights = options[:weights] || ({:title => 0.3, :description => 0.2, :lessons => 0.2, :keywords => 0.1})

    titleS = getSemanticDistance(courseA.name, courseB.name, options)
    keywordsS = getSemanticDistanceForKeywords(courseA.categories,courseB.categories)
    if options[:fast] == true
      descriptionS = 0
      lessonsS = 0
    else
      descriptionS = getSemanticDistance(courseA.description, courseB.description, options)
      lessonsS = getSemanticDistance(courseA.lessons_text, courseB.lessons_text, options)
    end

    return weights[:title] * titleS + weights[:description] * descriptionS + weights[:lessons] * lessonsS + weights[:keywords] * keywordsS
  end

  def self.calculateCourseRelevanceForUser(course, user, options={})
    #Filters
    return 0 if self.getSemanticDistanceForCategoricalFields(course.locale,user.ui_language) == 0
    userCourses = user.courses.where(:webinar => course.webinar)
    userCoursesIds = userCourses.map{|c| c.id}
    return 0 if userCoursesIds.include?(course.id)
    userCoursesIds = userCoursesIds.reject{|id| id == course.id}

    weights = options[:weights] || ({:courses => 0.5, :keywords => 0.5})

    coursesS = 0
    if userCoursesIds.length > 0
      csRecords = CourseSimilarity.where("course_similarities.course_a_id = ? OR course_similarities.course_b_id = ?", course.id, course.id)
      csRecords.where("course_similarities.course_a_id IN (?) OR course_similarities.course_b_id IN (?)", userCoursesIds, userCoursesIds)
      userCoursesIds.each do |cId|
        csRecord = csRecords.where("course_similarities.course_a_id = ? OR course_similarities.course_b_id = ?", [course.id,cId].min, [course.id,cId].max).first
        coursesS += (csRecord.nil? ? 0 : csRecord.value.to_f)
      end
      coursesS = (coursesS/userCoursesIds.length).to_f
    end
    
    userKeywords = user.tag_list.join(" ")
    keywordsS = getSemanticDistance(course.categories_text,userKeywords,options) + getSemanticDistance(course.name,userKeywords,options) + getSemanticDistance(course.description,userKeywords,options) + getSemanticDistance(course.lessons_text,userKeywords,options)
    
    return weights[:courses] * coursesS + weights[:keywords] * keywordsS
  end

  #Semantic distance in a [0,1] scale.
  #It calculates the semantic distance using the Cosine similarity measure, and the TF-IDF function to calculate the vectors.
  def self.getSemanticDistance(textA,textB, options)
    return 0 if (textA.blank? or textB.blank?)

    if options[:fast] == true
      textA = textA.first(50)
      textB = textB.first(50)
    end

    numerator = 0
    denominator = 0
    denominatorA = 0
    denominatorB = 0

    wordsTextA = getWordsFromText(processText(textA))
    wordsTextB = getWordsFromText(processText(textB))

    (wordsTextA.keys + wordsTextB.keys).uniq.each do |word|
      wordIDF = (options[:fast] == true ? 1 : IDF(word))
      tfidf1 = (wordsTextA[word] || 0) * wordIDF
      tfidf2 = (wordsTextB[word] || 0) * wordIDF
      numerator += (tfidf1 * tfidf2)
      denominatorA += tfidf1**2
      denominatorB += tfidf2**2
    end

    denominator = Math.sqrt(denominatorA) * Math.sqrt(denominatorB)
    return 0 if denominator==0

    20*numerator/denominator
  end

  # Inverse Document Frequency (IDF)
  def self.IDF(word)
    w = Word.find_by_value(word)
    occurrences = w.nil? ? 0 : w.occurrences
    return Math::log((2+ODC::Application::config.rs_total_entries)/(1+occurrences).to_f)
  end

  #Semantic distance in a [0,1] scale.
  #It calculates the semantic distance for keywords.
  def self.getSemanticDistanceForKeywords(keywordsA,keywordsB)
    return 0 if keywordsA.blank? or keywordsB.blank?
    return (2*(keywordsA & keywordsB).length)/(keywordsA.length+keywordsB.length).to_f
  end

  #Semantic distance in a [0,1] scale.
  #It calculates the semantic distance for categorical fields.
  #Return 1 if both fields are equal, 0 if not.
  def self.getSemanticDistanceForCategoricalFields(stringA,stringB)
    stringA = processText(stringA)
    stringB = processText(stringB)
    return 0 if stringA.blank? or stringB.blank?
    return 1 if stringA === stringB
    return 0
  end

  #Utils

  def self.getWordsFromText(text)
    return {} if text.blank?
    words = Hash.new
    text.split(" ").each do |word|
      word = word.gsub(/([.|;|:|,]$)/,"")
      words[word] = 0 if words[word].nil?
      words[word] += 1
    end
    words
  end

  def self.processText(text)
    return "" if text.blank? or !text.is_a? String
    text = ActionView::Base.full_sanitizer.sanitize(text)
    text = I18n.transliterate(text.gsub(/([\n])/," ").gsub(/([.|;|:|,]$)/,"").strip, :locale => "en").downcase
  end

end
