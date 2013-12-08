class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  check_authorization :unless => :devise_controller?

  before_filter :authenticate_user!

  def authenticate_admin_user!
    authenticate_user!
    raise CanCan::Unauthorized unless current_user.admin
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
