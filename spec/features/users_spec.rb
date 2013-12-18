require 'spec_helper'

describe 'Users' do
  let!(:user) { find_or_create_user }

  before { authenticate }

  context 'as an user' do
    context 'showing my profile' do
      it 'shows the user name' do
        click_link 'Profile'
        expect(page).to have_content(user.name)
        expect(page.current_path).to eql("/users/#{user.id}")
      end
    end
  end
end
