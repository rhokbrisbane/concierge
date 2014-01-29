class TagCategoriesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    @tag_category = TagCategory.new tag_category_params

    if @tag_category.save
      redirect_to tag_categories_path, notice: 'Category was successfully created.'
    else
      flash.now[:error] = @tag_category.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    if @tag_category.update tag_category_params
      redirect_to tag_categories_path, notice: 'Category was successfully updated.'
    else
      flash.now[:error] = @tag_category.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    @tag_category.destroy

    redirect_to tag_categories_path, notice: 'Category was successfully removed.'
  end

  private

  def tag_category_params
    params.require(:tag_category).permit(:name)
  end
end
