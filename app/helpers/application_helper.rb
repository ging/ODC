module ApplicationHelper
  
  def home_path
    return "/"
  end

  def options_for_select_ui_languages
    I18n.available_locales.map{|lanCode|
      [Utils.getReadableLanguage(lanCode.to_s),lanCode.to_s]
    }
  end

  def options_for_select_all_languages
    Utils.getAllLanguages.map{|lanCode|
      [Utils.getReadableLanguage(lanCode.to_s),lanCode.to_s]
    }
  end

  def formatted_duration(total_seconds)
      dhms = [60, 60, 24].reduce([total_seconds]) { |m,o| m.unshift(m.shift.divmod(o)).flatten }
      result = ""
      unless dhms[0].zero?
        result += "%d #{t('course.day')}(s) " % dhms
      end
      unless dhms[1].zero?
        result += "%d #{t('course.hour')}(s) " % dhms[1..3]
      end
      unless dhms[2].zero?
        result += "%d #{t('course.minute')}(s) " % dhms[2..3]
      end
      unless dhms[3].zero?
        result += "%d #{t('course.second')}(s) " % dhms[3]
      end
      result
  end

  def youtube_parse(url)
      if !url.match("/embed")
        code = url.scan(/(.*?)(^|\/|v=)([a-z0-9_-]{11})(.*)?/im)
        print code
        if code[0] and code[0][2]
          url = "https://www.youtube.com/embed/#{code[0][2].to_s}"
        end
      end
      url
  end

  def to_dmy(date, offset=0)
    # DateTime.parse(date).strftime("%d-%m-%Y")
    if date.methods.include? :strftime
      date = date - (offset||0).minutes
      date.strftime("%d/%m/%Y")
    else
      nil
    end
  end

  def to_dmy_alt(date, offset=0)
    if date.methods.include? :strftime
      date = date - (offset||0).minutes
      date.strftime("%d-%m-%Y")
    else
      nil
    end
  end

  def to_ymd(date, offset=0)
    if date.methods.include? :strftime
      date = date - (offset||0).minutes
      date.strftime("%Y-%m-%d")
    else
      nil
    end
  end

  # def to_dmyhm(date, offset)
  #   date = (date.to_time + offset / 60 ).to_datetime
  #   date.strftime("%d/%m/%Y %H:%M")
  # end

  def to_dmyhm(date, offset=0)
    if date.methods.include? :strftime
      date = date - (offset||0).minutes
      date.strftime("%d/%m/%Y %H:%M")
    else
      nil
    end
  end


  def to_seo_datetime(date)
    if date.methods.include? :strftime
      date.strftime("%Y-%m-%dT%H:%M:%S+00:00")
    else
      nil
    end
  end
  
  def platform_to_logo(platform)
    if platform == "Youtube"
      return "/img/vendors/youtube.svg"
    elsif platform == "Webex"
      return "/img/vendors/webex2.png"
    elsif platform == "Zoom"
      return "/img/vendors/zoom.png"
    elsif platform == "Teams"
      return "/img/vendors/teams.svg"
    elsif platform == "Meet"
      return "/img/vendors/meet.png"
    elsif platform == "Skype"
      return "/img/vendors/skype.svg"
    else
      return "/img/play.svg"
    end
  end

  def url_to_platform(url)
    if url.match("youtu")
      return "Youtube"
    elsif url.match("webex")
      return "Webex"
    elsif url.match("zoom")
      return "Zoom"
    elsif url.match("teams")
      return "Teams"
    elsif url.match("meet\.google")
      return "Meet"
    elsif url.match("skype") or url.match("meet\.lync")
      return "Skype"
    else
      return nil
    end
  end

end