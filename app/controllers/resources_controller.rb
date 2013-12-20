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

  def create
    @resource = Resource.new resource_params.merge(user: current_user)

    if @resource.save
      Address.create address_params.merge(addressable: @resource)
      redirect_to @resource, notice: 'Resource was successfully created.'
    else
      flash.now[:error] = @resource.errors.full_messages.join(', ')
      render action: 'new'
    end
  end

  def edit
    @address = @resource.address
  end

  def update
    if @resource.update(resource_params)
      @resource.address.update address_params
      redirect_to @resource, notice: 'Resource was successfully updated.'
    else
      flash.now[:error] = @resource.errors.full_messages.join(', ')
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

  def address_params
    params.require(:address).permit(:street1, :suburb, :state, :country)
  end
end
