class ResourcesController < ApplicationController
  load_and_authorize_resource

  def index
    @resources = Resource.all.group_by(&:category_humanize)
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
      @resource.create_address address_params
      redirect_to @resource, notice: 'Resource was successfully created.'
    else
      flash.now[:alert] = @resource.errors.full_messages.join(', ')
      render action: 'new'
    end
  end

  def edit
    @address = @resource.address
  end

  def update
    @resource = Resource.find params[:id]
    @address = @resource.build_address || @resource.address

    if @resource.update(resource_params) && @address.update(address_params)
      redirect_to @resource, notice: 'Resource was successfully updated.'
    else
      flash.now[:alert] = @resource.errors.full_messages.join(', ')
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
  rescue ActiveRecord::RecordInvalid
    @flash = { class_name: 'alert', message: 'Tag has already been taken' }
  end

  def remove_tag
    @resource.taggings.find_by_tag_id(params[:tag_id]).destroy
    head :no_content
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :tag_category, :url, :phone, :facebook, :twitter, :description, :avatar, :region)
  end

  def address_params
    params.require(:address).permit(:street1, :suburb, :state, :country)
  end
end
