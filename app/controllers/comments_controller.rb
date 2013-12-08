class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type)
  end
end

