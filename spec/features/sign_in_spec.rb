require 'spec_helper'

describe 'Sign In' do
  context 'as an user' do
    let!(:user) { create :user }

    it 'can sign in' do
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'rhok2013'

      click_button 'Sign in'

      expect(page).to have_content('Signed in successfully.')
      expect(page.current_path).to eql('/')
    end
  end
end
