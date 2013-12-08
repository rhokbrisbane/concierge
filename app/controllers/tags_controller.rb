class TagsController < ApplicationController
  before_action :set_tag, only: [:show]

  def show
    @taggings = @tag.taggings.group_by(&:taggable_type)
    # @taggings = @tag.taggings.map(&:taggable)
  end

  private

    def set_tag
      @tag = Tag.find(params[:id])
    end

end
