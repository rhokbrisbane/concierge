class TagsController < ApplicationController
  load_and_authorize_resource

  before_action :load_categories, only: [:new, :edit]

  def index
  end

  def show
    @taggings = @tag.taggings.includes(:taggable).map(&:taggable)
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to @tag, notice: 'Tag was successfully created.'
    else
      load_categories
      render action: 'new'
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to @tag, notice: 'Tag was successfully updated.'
    else
      load_categories
      render action: 'edit'
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_url, notice: 'Tag was successfully deleted.'
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :category_id, :description)
  end

  def load_categories
    @categories = TagCategory.for_select
  end
end
