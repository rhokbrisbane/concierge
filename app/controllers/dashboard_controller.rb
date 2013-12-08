class DashboardController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    if current_user
      @kids = current_user.kids
      @saved_searches = current_user.saved_searches
    end

    @tags_by_category = Tag.where(category: ['symtoms', 'needs', 'weight_group', 'age_group']).group_by(&:category)
  end
end
