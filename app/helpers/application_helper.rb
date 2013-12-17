module ApplicationHelper
  def login_options
    if user_signed_in?
      link_to('Profile', user_path(current_user), title: current_user.name) +
      link_to("Sign Out", destroy_user_session_path, method: :delete)
    else
      content_tag(:span, "Sign In With:") +
      link_to("Email", new_user_session_path) +
      link_to("Facebook", user_omniauth_authorize_path(:facebook))
    end
  end
end
