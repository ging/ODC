# encoding: utf-8

class RecommenderSystem

  def self.getRecommendCourses(course,n=4)
    #filter courses and webinars only in the language of the page, or in spanish if page is in english
    pagelang = I18n.locale.to_s
    if course.categories.blank?
      suggestions = default_suggested_courses(course, pagelang)
    else
	    suggestions = Course.where("webinar = ? and categories is NOT NULL and id != ?", course.webinar, course.id).where(:card_lang => pagelang).select{|c| (c.categories & course.categories).length > 0}
      suggestions = default_suggested_courses(course, pagelang) if suggestions.blank?
    end
    suggestions.sample(n)
  end

  def self.default_suggested_courses(course, pagelang="es")
	  Course.where("webinar = ? and id != ?", course.webinar, course.id).where(:card_lang => pagelang)
  end


  #Metrics

  def self.calculateCourseSimilarity(courseA, courseB, options={})
    weights = options[:weights] || ({:title => 0.3, :description => 0.2, :lessons => 0.2, :keywords => 0.1, :language => 0.2})

    titleS = 20 * getSemanticDistance(courseA.name, courseB.name)
    descriptionS = 20 * getSemanticDistance(courseA.description, courseB.description)
    lessonsS = 20 * getSemanticDistance(courseA.lessons_text, courseB.lessons_text)
    keywordsS = getSemanticDistanceForKeywords(courseA.categories,courseB.categories)
    languageS = getSemanticDistanceForLanguage(courseA.locale,courseB.locale)

    return weights[:title] * titleS + weights[:description] * descriptionS + weights[:lessons] * lessonsS + weights[:keywords] * keywordsS + weights[:language] * languageS
  end

  #Semantic distance in a [0,1] scale.
  #It calculates the semantic distance using the Cosine similarity measure, and the TF-IDF function to calculate the vectors.
  def self.getSemanticDistance(textA,textB)
    return 0 if (textA.blank? or textB.blank?)

    numerator = 0
    denominator = 0
    denominatorA = 0
    denominatorB = 0

    wordsTextA = getWordsFromText(processText(textA))
    wordsTextB = getWordsFromText(processText(textB))

    (wordsTextA.keys + wordsTextB.keys).uniq.each do |word|
      wordIDF = IDF(word)
      tfidf1 = (wordsTextA[word] || 0) * wordIDF
      tfidf2 = (wordsTextB[word] || 0) * wordIDF
      numerator += (tfidf1 * tfidf2)
      denominatorA += tfidf1**2
      denominatorB += tfidf2**2
    end

    denominator = Math.sqrt(denominatorA) * Math.sqrt(denominatorB)
    return 0 if denominator==0

    numerator/denominator
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
  #It calculates the semantic distance for languages.
  def self.getSemanticDistanceForLanguage(stringA,stringB)
    return 0 if (Utils.valid_locale?(stringA) == false or Utils.valid_locale?(stringB) == false)
    return getSemanticDistanceForCategoricalFields(stringA,stringB)
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
