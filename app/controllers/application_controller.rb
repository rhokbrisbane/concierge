class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # TODO: uncomment this when Facebook authentication is working!
  # before_filter :authenticate_user!
end
