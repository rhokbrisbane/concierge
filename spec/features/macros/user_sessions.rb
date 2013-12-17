module AcceptanceMacros
  def find_or_create_user(admin: false)
    user_info = { email: 'user@example.com', password: 'secret1234', password_confirmation: 'secret1234', admin: admin }

    User.where(email: user_info[:email]).first || create(:user, user_info)
  end

  def authenticate
    visit new_user_session_path

    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'secret1234'
    click_button 'Sign in'
  end
end
