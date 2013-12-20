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

    context 'updating the user profile' do
      shared_examples 'user profile' do
        it 'updates the user and the address' do
          visit user_path(_user)
          click_link 'Edit profile'

          fill_in 'Name',    with: 'New Name'
          fill_in 'Street',  with: 'New Street'
          fill_in 'Suburb',  with: 'New Suburb'
          fill_in 'State',   with: 'New State'
          fill_in 'Country', with: 'New Country'
          click_button 'Save'

          expect(page).to have_content('User was successfully updated.')
          expect(_user.reload.name).to     eql('New Name')
          expect(_user.address.street1).to eql('New Street')
          expect(_user.address.suburb).to  eql('New Suburb')
          expect(_user.address.state).to   eql('New State')
          expect(_user.address.country).to eql('New Country')
        end
      end

      context 'when user does not have an address' do
        let(:_user) { user.address = nil; user }
        it_should_behave_like 'user profile'
      end

      context 'when user already has an address' do
        let(:_user) { user.address = create :address; user }
        it_should_behave_like 'user profile'
      end

      context 'when address fields is blank' do
        it 'returns a error message' do
          visit user_path(user)
          click_link 'Edit profile'
          click_button 'Save'

          expect(page).to have_content("Street1 can't be blank")
          expect(page).to have_content("Suburb can't be blank")
          expect(page).to have_content("State can't be blank")
          expect(page).to have_content("Country can't be blank")
        end
      end
    end
  end
end
