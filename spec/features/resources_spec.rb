require 'spec_helper'

describe 'Resources' do
  let!(:user) { find_or_create_user }

  before { authenticate }

  context 'as an user' do
    context 'showing resource details' do
      let!(:resource) { create :resource, user: user }

      it 'shows the resource details' do
        visit resource_path(resource)
        expect(page).to have_content(resource.name)
        expect(page).to have_content(resource.category_humanize)
        expect(page).to have_content(resource.url)
        expect(page).to have_content(resource.phone)
        expect(page).to have_content("facebook.com/#{resource.facebook}")
        expect(page).to have_content("twitter.com/#{resource.twitter}")
      end
    end

    context 'creating a resource' do
      it 'creates a resource' do
        click_link 'Create a resource'

        fill_in 'Name',     with: 'Good Foundation'
        select  'Info',     from: 'Category'
        fill_in 'Url',      with: 'http://goodfoundation.com/'
        fill_in 'Phone',    with: '+61 1234 567 890'
        fill_in 'Facebook', with: 'goodfoundation'
        fill_in 'Twitter',  with: 'goodfoundation'

        expect { click_button 'Save' }.to change { Resource.count }.by(1)
        expect(page).to have_content('Resource was successfully created.')
      end
    end
  end
end
