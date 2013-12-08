class DashboardController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    @new_kid = Kid.new
    @tags_by_category = Tag.all.group_by(&:category)
  end
end
