class Api::V1::ResourcesController < ApplicationController
  load_and_authorize_resource :resource, except: :create

  def index
    render json: @resources
  end

  def show
    render json: @resource
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      render json: @resource
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  def update
    if  @resource.update(resource_params)
      render json: @resource
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @resource.destroy
    head :no_content
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :content)
  end
end
