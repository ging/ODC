# encoding: utf-8

class RecommenderSystem

  def self.getRecommendCourses(course,n=4)
    getSimilarCourses(course,n)
  end

  def self.getSimilarCourses(c,n=10)
    results = self.getSimilarCoursesFromDb(c,n)
    return getSimilarCoursesInRealTime(c,n) if results.blank?
    return results
  end

  def self.getSimilarCoursesFromDb(c,n=10)
    csRecords = CourseSimilarity.where("course_similarities.course_a_id = ? OR course_similarities.course_b_id = ?", c.id, c.id).sort_by{|cs| -cs.value}.first(n*2).sample(n)
    return [] if csRecords.blank?
    csRecords.each do |cs|
      cs.course_id = [cs.course_a_id,cs.course_b_id].reject{|id| id == c.id}.first
    end
    courses = Course.find(csRecords.map{|cs| cs.course_id})
    results = courses.map{|c| {:course => c, :score => csRecords.select{|cs| cs.course_id == c.id}.first.value.to_f}}.sort_by{|r| -r[:score]}
    results.map{|r| r[:course]}
  end

  def self.getSimilarCoursesInRealTime(c,n=10)
    preSelection = []
    unless c.categories.blank?
      preSelection = Course.where("webinar = ? and categories is NOT NULL and id != ?", c.webinar, c.id).where(:card_lang => c.card_lang).select{|rc| (rc.categories & c.categories).length > 0}
    end
    if preSelection.length < n
      preSelection = Course.where("webinar = ? and id != ?", c.webinar, c.id).where(:card_lang => c.card_lang)
    end

    preSelection = preSelection.sample(50).sort_by{ |candidate| -self.calculateCourseSimilarity(c,candidate,{:fast => true}) }.first(n).sample(n)

    return preSelection
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
