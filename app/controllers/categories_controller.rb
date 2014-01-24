class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @category = Category.new category_params

    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      flash.now[:error] = @category.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    if @category.update category_params
      redirect_to categories_path, notice: 'Category was successfully updated.'
    else
      flash.now[:error] = @category.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    @category.destroy

    redirect_to categories_path, notice: 'Category was successfully removed.'
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
