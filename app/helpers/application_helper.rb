module ApplicationHelper

  def login_options
    if signed_in?
      content_tag(:span, current_user.email, class: "current-user-email") +
      link_to('Sign Out', destroy_user_session_path, method: :delete, class: "icon-exit button")
    else
      render "layouts/authentication_links"
    end
  end
end


