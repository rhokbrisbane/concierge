class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    set_flash_message :notice, :signed_up
    new_saved_search_path
  end
end
