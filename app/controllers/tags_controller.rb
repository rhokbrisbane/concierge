class TagsController < ApplicationController
  load_and_authorize_resource

  def show
    @taggings = @tag.taggings.includes(:taggable).map(&:taggable)
  end
end
