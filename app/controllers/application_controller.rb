class ApplicationController < ActionController::Base

  require 'auth_token'
  #include ActionController::Serialization

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session
  #protect_from_forgery with: :exception


  # devise
  def after_sign_in_path_for(resource)
    "/"
  end


  protected

  ##
  # This method can be used as a before filter to protect
  # any actions by ensuring the request is transmitting a
  # valid JWT
  def verify_jwt_token
    head :unauthorized if request.headers['Authorization'].nil? ||
        !AuthToken.valid?(request.headers['Authorization'].split(' ').last)
  end

end
