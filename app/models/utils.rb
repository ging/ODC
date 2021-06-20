# encoding: utf-8

class Utils

  #################
  # Languages Utils
  #################

  def self.valid_locale?(locale)
    locale.is_a? String and I18n.available_locales.include? locale.to_sym
  end

  def self.getAllLanguages
    I18n.available_locales.map{|l| l.to_s}
  end

  #Translate ISO 639-1 codes to readable language names
  def self.getReadableLanguage(lanCode="")
    I18n.t("languages." + lanCode.to_s, :default => lanCode.to_s)
  end

  def self.id_for_locale(locale)
    return nil unless Utils.valid_locale?(locale)
    return (1 + ODC::Application.config.i18n.available_locales.index(locale.to_sym))
  end

  def self.id_for_category(c)
    index = ["esafety", "inclusion", "climate", "entrepreneurship"].index(c)
    return 1+index unless index.nil?
  end

  def self.getOptionsForCategories
    I18n.t("categories").map{|k,v| [v,k.to_s]}
  end

  #Change URLs to https when clientProtocol is HTTPs
  def self.checkUrlProtocol(url,clientProtocol)
    return url unless url.is_a? String and clientProtocol.include?("https")
    protocolMatch = url.scan(/^https?:\/\//)
    return url if protocolMatch.blank?

    urlProtocol = protocolMatch[0].sub(":\/\/","")
    clientProtocol = clientProtocol.sub(":\/\/","")

    if (urlProtocol != clientProtocol)
      case(clientProtocol)
        when "https"
          #Try to load HTTP url over HTTPs
          url = "https" + url.sub(urlProtocol,"") #replace first
        when "http"
          #Try to load HTTPs url over HTTP. Do nothing.
        else
         #Document is not loaded over HTTP or HTTPs. Do nothing.
        end
    end
    return url
  end

  def self.isUserAgentBot?(user_agent)
    return true if user_agent.blank?
    matches = user_agent.match(/(BingPreview|eSobiSubscriber|startmebot|Mail.RU_Bot|SeznamBot|360Spider|bingbot|MJ12bot|web spider|YandexBot|Baiduspider|AhrefsBot|OrangeBot|msnbot|spbot|facebook|postrank|voyager|twitterbot|googlebot|slurp|butterfly|pycurl|tweetmemebot|metauri|evrinid|reddit|digg)/mi)
    return true unless matches.nil?
    require "browser"
    browser = Browser.new(user_agent)
    return browser.bot?
  end

end