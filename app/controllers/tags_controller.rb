class TagsController < ApplicationController
  load_and_authorize_resource

  def show
    @taggings = @tag.taggings.map(&:taggable)
  end
end
