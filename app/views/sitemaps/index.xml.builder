xml.instruct! :xml, version: '1.0'
xml.tag! 'sitemapindex', 'xmlns' => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.tag! 'url' do
    xml.tag! 'loc', root_url
  end

  xml.tag! 'url' do
    xml.tag! 'loc', root_url + "about_me"
  end
  xml.tag! 'url' do
    xml.tag! 'loc', root_url + "courses"
  end
  xml.tag! 'url' do
    xml.tag! 'loc', root_url + "webinars"
  end
  @courses.each do |course|
    xml.tag! 'url' do
      xml.tag! 'loc', course_url(course)
      xml.lastmod course.updated_at.strftime("%F")
    end
  end

end