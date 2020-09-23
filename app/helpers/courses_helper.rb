module CoursesHelper
	def webinars_path
		return "/webinars"
	end

	def enroll_path(course)
		return course_path(course) + "/enroll"
	end

	def unenroll_path(course)
		return course_path(course) + "/unenroll"
	end

	def rate_path(course)
		return course_path(course) + "/rate"
	end

	def parse_date(date, hour=false, offset = 0)
		begin
			date = DateTime.strptime(date, hour ?  "%d/%m/%Y %H:%M" : "%d/%m/%Y")
			date = (date + (offset).minutes)
			date
		rescue
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
