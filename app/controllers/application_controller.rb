class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  check_authorization unless: :admin_or_devise_controller?

  before_filter :authenticate_user!
  before_filter :fetch_tags_by_category

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  private

  def fetch_tags_by_category
    @tags_by_category = Tag.all.group_by(&:category)
  end

  def authenticate_admin_user!
    authenticate_user!
    unless current_user.admin?
      redirect_to root_url, alert: 'You cannot access that resource'
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def admin_or_devise_controller?
    self.kind_of?(ActiveAdmin::BaseController) || devise_controller?
  end
end
