class UsersController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    @tags = Tag.all.reject{ |tag| @user.tags.include?(tag) }
    @user_tags = @user.tags
    @comments = [*@user.comments + @user.comments_as_subject].uniq_by(&:id)
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
        flash.now[:alert] = @address.errors.full_messages.to_sentence
        render action: 'edit'
      end
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render action: 'edit'
    end
  end

  def add_tag
    tag = Tag.find params[:tag_id]
    @user.tags << tag
  rescue ActiveRecord::RecordInvalid
    @flash = { class_name: 'alert', message: 'Tag has already been taken' }
  end

  def remove_tag
    @user.taggings.find_by_tag_id(params[:tag_id]).destroy
    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :public)
  end

  def address_params
    params.require(:address).permit(:street1, :suburb, :state, :country)
  end
end
