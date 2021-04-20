class ErrorsController < ApplicationController
  skip_authorization_check :only => [:not_found, :unacceptable, :internal_server_error]

  def not_found
    render status: 404
  end

  def unacceptable
    render status: 422
  end

  def internal_server_error
    render status: 500
  end

end