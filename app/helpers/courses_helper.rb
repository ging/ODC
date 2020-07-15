module CoursesHelper
	def parse_date(date, hour=false)
    	DateTime.strptime(date, hour ?  "%d/%m/%Y %H:%M" : "%d/%m/%Y")
  	end
end
