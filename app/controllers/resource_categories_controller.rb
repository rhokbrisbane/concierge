class ResourceCategoriesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def create
    @resource_category = ResourceCategory.new resource_category_params

    if @resource_category.save
      redirect_to resource_categories_path, notice: 'Category was successfully created.'
    else
      flash.now[:error] = @resource_category.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    if @resource_category.update resource_category_params
      redirect_to resource_categories_path, notice: 'Category was successfully updated.'
    else
      flash.now[:error] = @resource_category.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def resource_category_params
    params.require(:resource_category).permit(:name)
  end
end
