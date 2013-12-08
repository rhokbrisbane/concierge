class DashboardController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_authorization_check

  def index
    if current_user
      @kids = current_user.kids
      @saved_searches = current_user.saved_searches
    end
  end
end
