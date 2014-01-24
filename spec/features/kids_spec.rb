require 'spec_helper'

describe 'Kids' do
  let!(:user) { find_or_create_user }

  before { authenticate }

  context 'as an user' do
    context 'listing kids profiles' do
      let!(:kid_1) { create :kid, guardians: [user] }
      let!(:kid_2) { create :kid, guardians: [user] }

      it 'shows the kids names' do
        visit root_path
        expect(page).to have_content(kid_1.name)
        expect(page).to have_content(kid_2.name)
      end
    end

    context 'showing kid details' do
      let!(:kid) { create :kid, guardians: [user] }

      it 'shows the kid name' do
        visit kid_path(kid)
        expect(page).to have_content(kid.name)
      end
    end

    context 'creating a kid profile' do
      it 'creates a kid' do
        click_link 'New child profile'

        fill_in 'Name', with: 'Kid 1'

        expect { click_button 'Save' }.to change { Kid.count }.by(1)
        expect(page).to have_content("Kid 1's details have been saved.")
      end
    end

    context 'updating a kid profile' do
      let!(:kid) { create :kid, guardians: [user] }

      it 'updates a kid' do
        visit kid_path(kid)
        click_link 'Edit'

        fill_in 'Name', with: 'New name'

        click_button 'Save'
        expect(page).to have_content("New name's details have been saved.")
      end
    end
  end
end
