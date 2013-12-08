class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate_user!
  before_filter :fetch_tags_by_category

  private
  def fetch_tags_by_category
    @tags_by_category = Tag.all.group_by(&:category)
  end
end
