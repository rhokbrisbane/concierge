class Api::V1::PointsController < ApplicationController
  def index
    render json: @resource.to_json
  end

  def create
    if @resource.save
      render json: @resource, serializer: PointSerializer
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  def update
    if  @resource.update(point_params)
      render json: @resource, serializer: PointSerializer
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @resource.destroy
    head :no_content
  end
end