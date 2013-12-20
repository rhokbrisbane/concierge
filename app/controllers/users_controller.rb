class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @tags = Tag.all.reject{ |tag| @user.tags.include?(tag) }
    @user_tags = @user.tags
  end

  def edit
    @address = @user.address
  end

  def update
    if @user.update(user_params)
      @address = @user.address || @user.build_address

      if @address.update address_params
        redirect_to @user, notice: 'User was successfully updated.'
      else
        flash.now[:alert] = @address.errors.full_messages.join(', ')
        render action: 'edit'
      end
    else
      flash.now[:alert] = @user.errors.full_messages.join(', ')
      render action: 'edit'
    end
  end

  def add_tag
    tag = Tag.find params[:tag_id]
    @user.tags << tag
    head :no_content
  end

  def remove_tag
    @user.tags.find(params[:tag_id]).destroy
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def address_params
    params.require(:address).permit(:street1, :suburb, :state, :country)
  end
end
