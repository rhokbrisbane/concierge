require 'spec_helper'

describe 'Sign Up' do
  context 'as an user' do
    it 'can sign up' do
      visit new_user_registration_path

      fill_in 'Email', with: 'email@example.com'
      fill_in 'Password', with: 'secret1234'
      fill_in 'Password confirmation', with: 'secret1234'

      expect { click_button 'Sign up' }.to change{ User.count }.by(1)

      expect(page).to have_content('Welcome! You have signed up successfully.')
      expect(page.current_path).to eql('/saved_searches/new')
    end
  end
end
