class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @tags = Tag.all.reject{|tag| @user.tags.include? tag}
  end

  def add_tag
    tag = Tag.find params[:tag_id]
    @user.tags << tag
  end
end
