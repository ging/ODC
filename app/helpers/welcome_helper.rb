module WelcomeHelper
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
end
