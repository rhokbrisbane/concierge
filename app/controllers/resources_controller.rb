class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @resource = Resource.new
  end

  def edit
  end

  def create
    @resource = Resource.new(resource_params)

    if @resource.save
      redirect_to @resource, notice: 'resource was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @resource.update(resource_params)
      redirect_to @resource, notice: 'resource was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @resource.destroy
    redirect_to resources_url, notice: 'resource was successfully destroyed.'
  end


  private

    def set_resource
      @resource = Resource.find(params[:id])
    end
end
