class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception

  protected
  def standard_error_message(error)
    render json: { message: error.message }, status: 500
  end

end
