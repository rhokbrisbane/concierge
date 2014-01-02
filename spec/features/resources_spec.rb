require 'spec_helper'

describe 'Resources' do
  let!(:user) { find_or_create_user }

  before { authenticate }

  context 'as an user' do
    let!(:resource) { create :resource, user: user }

    context 'showing resource details' do
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

    context 'including tag' do
      let!(:tag) { create :tag }

      it 'creates a tag', js: true do
        visit resource_path(resource)

        page.execute_script("$('#tag_id').show()")
        select tag.name, from: 'tag_id'

        expect do
          click_button('Add Tag')
          wait_ajax
        end.to change { Tagging.count }.by(1)

        within '.current_tags' do
          expect(page).to have_content(tag.name)
        end
      end
    end

    context 'creating a resource' do
      before do
        click_link 'Create a resource'

        fill_in 'Name',     with: 'Good Foundation'
        select  'Info',     from: 'Category'
        fill_in 'Url',      with: 'http://goodfoundation.com/'
        fill_in 'Phone',    with: '+61 1234 567 890'
        fill_in 'Facebook', with: 'goodfoundation'
        fill_in 'Twitter',  with: 'goodfoundation'
        fill_in 'Street',   with: 'Some Street'
        fill_in 'Suburb',   with: 'Some Suburb'
        fill_in 'State',    with: 'Some State'
        fill_in 'Country',  with: 'Some Country'
      end

      it 'creates a resource' do
        expect { click_button 'Save' }.to change { Resource.count }.by(1)
        expect(page).to have_content('Resource was successfully created.')
      end

      it 'creates an address' do
        expect { click_button 'Save' }.to change { Address.count }.by(1)
      end
    end

    context 'updating a resource' do
      let :resource do
        create(:resource, user: user).tap do |r|
          r.address = create(:address, addressable: r)
        end
      end


      it 'updates the resource and the address' do
        visit resource_path(resource)
        click_link 'Edit'

        fill_in 'Name',   with: 'New Name'
        fill_in 'Street', with: 'New Street'
        click_button 'Save'

        expect(page).to have_content('Resource was successfully updated.')
        expect(resource.reload.name).to eql('New Name')
        expect(resource.address.street1).to eql('New Street')
      end
    end
  end
end
