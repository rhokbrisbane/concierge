class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :fetch_tags_by_category
  before_filter :fetch_pages

  private

  def fetch_pages
    @pages = Page.all.reject {|p| p.id == 1 }
  end

  def fetch_tags_by_category
    @tags_by_category = Tag.includes(:tag_category).group_by(&:tag_category)
  end
end
