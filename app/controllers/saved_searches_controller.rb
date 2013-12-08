class SavedSearchesController < ApplicationController 
  def new
    @tags_by_category = Tag.all.group_by(&:category)
  end
end
