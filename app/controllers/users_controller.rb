class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @tags      = Tag.all.reject{|tag| @user.tags.include? tag}
    @user_tags = @user.tags
  end

  def add_tag
    tag = Tag.find params[:tag_id]
    @user.tags << tag
    head :no_content
  end

  def remove_tag
    @user.tags.find(params[:tag_id]).destroy
  end
end
