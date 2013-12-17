require 'spec_helper'

describe 'Dashboard', type: :feature do
  context 'without authentication' do
    it 'redirects to sign in page' do
      visit admin_root_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(page.current_path).to eql('/users/sign_in')
    end
  end

  context 'authenticating with a simple user' do
    before do
      find_or_create_user
      authenticate
      visit admin_root_path
    end

    it 'shows a error message' do
      expect(page).to have_content('You cannot access that resource')
    end

    it 'redirects to initial page' do
      expect(page.current_path).to eql('/')
    end
  end

  context 'authenticating with an admin user' do
    before do
      find_or_create_user(admin: true)
      authenticate
      visit admin_root_path
    end

    it 'has a welcome text' do
      expect(page).to have_content('Welcome to Concierge - Admin page.')
    end

    ['Dashboard', 'Users'].each do |menu_title|
      it "has a '#{menu_title}' menu" do
        expect(page).to have_content(menu_title)
      end
    end
  end
end
