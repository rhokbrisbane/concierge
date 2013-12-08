class DashboardController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    if current_user
      @kids = current_user.kids
      @saved_searches = current_user.saved_searches

      binding.pry
    end
  end
end
