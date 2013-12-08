class UsersController < ApplicationController
  before_action :set_user, only: [:show, :add_tag]

  def show
    @tags = Tag.all.reject{|tag| @user.tags.include? tag}
  end

  def add_tag
    tag = Tag.find params[:tag_id]
    @user.tags << tag
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
