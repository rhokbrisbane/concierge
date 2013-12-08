class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @tags = Tag.all
    # @tags = Tag.all.reject { |tag| ... 'Where is not already associated with user' }
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

end
