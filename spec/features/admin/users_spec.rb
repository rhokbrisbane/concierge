require 'spec_helper'

describe 'User' do
  let!(:user) { create(:user) }

  context 'as an admin' do
    before do
      find_or_create_user(admin: true)
      authenticate
    end

    it 'index' do
      visit admin_users_path
    end

    it 'show' do
      visit admin_user_path(user)
    end

    it 'new' do
      visit new_admin_user_path
    end

    it 'edit' do
      visit edit_admin_user_path(user)
    end
  end
end
