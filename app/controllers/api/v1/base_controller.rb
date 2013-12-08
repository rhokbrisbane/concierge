class Api::V1::BaseController < ActionController::Base
  before_action :restrict_access
  check_authorization

  private
  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(api_token: token)
    end
  end
end
