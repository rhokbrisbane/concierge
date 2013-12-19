class ResourcesController < ApplicationController
  load_and_authorize_resource

  def index
    @resources = Resource.all
  end

  def show
    @tags = Tag.all.reject{ |tag| @resource.tags.include?(tag) }
    @resource_tags = @resource.tags
  end

  def new
    @resource = Resource.new
  end

  def edit
  end

  def create
    @resource = Resource.new resource_params.merge(user: current_user)

    if @resource.save
      redirect_to @resource, notice: 'Resource was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @resource.update(resource_params)
      redirect_to @resource, notice: 'Resource was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @resource.destroy
    redirect_to resources_url, notice: 'Resource was successfully destroyed.'
  end

  def add_tag
    tag = Tag.find params[:tag_id]
    @resource.tags << tag
    head :no_content
  end

  def remove_tag
    @resource.tags.find(params[:tag_id]).destroy
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :category, :url, :phone, :facebook, :twitter)
  end

  def set_resource
    @resource = Resource.find(params[:id])
  end
end
