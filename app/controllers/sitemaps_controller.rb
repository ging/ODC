# app/controllers/sitemaps_controller.rb

class SitemapsController < ApplicationController

  layout :false
  before_action :init_sitemap, :except => [:robots]
  skip_authorization_check :only => [:index, :robots]


  def index
    @courses = Course.all
  end

  def robots
  	respond_to :text
  end

  private

  def init_sitemap
    headers['Content-Type'] = 'application/xml'
  end



end