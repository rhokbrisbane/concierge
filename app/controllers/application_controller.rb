class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  check_authorization :unless => :devise_controller?

  # TODO: uncomment this when Facebook authentication is working!
  # before_filter :authenticate_user!
end
