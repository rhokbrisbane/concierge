class ResourcesController < ApplicationController
  load_and_authorize_resource

  def show
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

  private

  def resource_params
    params.require(:resource).permit(:name, :category, :url, :phone, :facebook, :twitter)
  end

  def set_resource
    @resource = Resource.find(params[:id])
  end
end
