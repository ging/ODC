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

  def to_dmy(date, offset=0, timezone = "Europe/Madrid")
    # DateTime.parse(date).strftime("%d-%m-%Y")
    if date.methods.include? :strftime
      date = timezone  ? date.in_time_zone(timezone) :(date - (offset||0).minutes)
      date.strftime("%d/%m/%Y")
    else
      nil
    end
  end

  def to_dmy_alt(date, offset=0, timezone = "Europe/Madrid")
    if date.methods.include? :strftime
      date = timezone  ? date.in_time_zone(timezone) :(date - (offset||0).minutes)
      date.strftime("%d-%m-%Y")
    else
      nil
    end
  end

  def to_ymd(date, offset=0, timezone = "Europe/Madrid")
    if date.methods.include? :strftime
      date = timezone  ? date.in_time_zone(timezone) :(date - (offset||0).minutes)
      date.strftime("%Y-%m-%d")
    else
      nil
    end
  end

  # def to_dmyhm(date, offset)
  #   date = (date.to_time + offset / 60 ).to_datetime
  #   date.strftime("%d/%m/%Y %H:%M")
  # end

  def to_dmyhm(date, offset=0, timezone= "Europe/Madrid", at=nil, only_hour = nil)
    if date.methods.include? :strftime
      date = timezone  ? date.in_time_zone(timezone) : (date - (offset||0).minutes)
      if only_hour
        date.strftime("%H:%M")
      else
        date.strftime("%d/%m/%Y #{at ? (at + " "): ""}%H:%M")
      end
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
    img_dir = "/img/vendors/"
    if platform == "Youtube"
      return "#{img_dir}youtube.svg"
    elsif platform == "Webex"
      return "#{img_dir}webex2.png"
    elsif platform == "Zoom"
      return "#{img_dir}zoom.png"
    elsif platform == "Teams"
      return "#{img_dir}teams.svg"
    elsif platform == "Meet"
      return "#{img_dir}meet.png"
    elsif platform == "Skype"
      return "#{img_dir}skype.svg"
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

  def calculate_duration(start_date, end_date, force, offset, timezone)
    course_date = ""
    if (start_date and end_date) 
      if (start_date.to_date == end_date.to_date) or force
        course_date = ("#{to_dmyhm(start_date,offset,timezone)} - #{to_dmyhm(end_date,offset,timezone,nil,!force)}") 
      else
        course_date = ("#{to_dmy(start_date,offset,timezone)} - #{to_dmy(end_date,offset,timezone)}") 
      end
    end
    course_date
  end

  def calculate_duration_complete(start_date, end_date, offset,timezone)
    course_date = ""
    if (start_date and end_date) 
        course_date = ("#{to_dmyhm(start_date,offset,timezone)} - #{to_dmyhm(end_date,offset,timezone)}") 
    end
    course_date
  end
end