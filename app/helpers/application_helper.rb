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
      code = url.scan(/v=(\w+)/)
      if code[0] and code[0][0]
        url = "https://www.youtube.com/embed/#{code[0][0].to_s}"
      end
    end
    url
  end

  def to_dmy(date)
    # DateTime.parse(date).strftime("%d-%m-%Y")
    date.strftime("%d/%m/%Y")
  end

  def to_ymd(date)
    date.strftime("%Y-%m-%d")
  end

  def to_dmyhm(date, offset = 0)
    date = (date.to_time + offset / 60 ).to_datetime
    date.strftime("%d/%m/%Y %H:%M")
  end

  def to_seo_datetime(date)
    date.strftime("%Y-%m-%dT%H:%M:%S+00:00")
  end


end