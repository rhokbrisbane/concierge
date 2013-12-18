require 'spec_helper'

describe 'Kids' do
  let!(:user) { find_or_create_user }

  before { authenticate }

  context 'as an user' do
    context 'listing kids profiles' do
      let!(:kid_1) { create :kid, guardians: [user] }
      let!(:kid_2) { create :kid, guardians: [user] }

      it 'shows all kids' do
        visit root_path
        expect(page).to have_content(kid_1.name)
        expect(page).to have_content(kid_2.name)
      end
    end

    context 'creating a kid profile' do
      it 'creates a kid' do
        click_link 'Create a new kid profile'

        fill_in 'Name', with: 'Kid 1'

        expect { click_button 'Save' }.to change { Kid.count }.by(1)
        expect(page).to have_content("Kid 1's details have been saved.")
      end
    end
  end
end
