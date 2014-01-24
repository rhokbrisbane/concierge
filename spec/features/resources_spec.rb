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

    context 'removing tag' do
      before { pending }

      let!(:tag) { create :tag }

      it 'removes a tag', js: true do
        resource.tags << tag

        visit resource_path(resource)

        within '.current_tags' do
          expect(page).to have_content(tag.name)

          expect do
            find('.tag .remove').click
            wait_ajax
          end.to change { Tagging.count }.by(-1)

          expect(page).to have_no_content(tag.name)
        end
      end
    end

    context 'creating a resource' do
      before do
        visit new_resource_path

        fill_in 'Name',     with: 'Good Foundation'
        select  'Info',     from: 'Category'
        fill_in 'Url',      with: 'http://goodfoundation.com/'
        fill_in 'Phone',    with: '+61 1234 567 890'
        fill_in 'Facebook', with: 'goodfoundation'
        fill_in 'Twitter',  with: 'goodfoundation'
      end

      context 'with address attributes' do
        before do
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

          address_attributes = Address.last.attributes.select { |k, _| %w(street1 suburb state country).include?(k) }

          expect(address_attributes).to eql({
             'suburb' => 'Some Suburb',
            'street1' => 'Some Street',
              'state' => 'Some State',
            'country' => 'Some Country'
          })
        end
      end

      context 'with street attribute' do
        before do
          fill_in 'Street', with: 'Some Street'
        end

        it 'creates a resource' do
          expect { click_button 'Save' }.to change { Resource.count }.by(1)
          expect(page).to have_content('Resource was successfully created.')
        end

        it 'creates an address' do
          expect { click_button 'Save' }.to change { Address.count }.by(1)

          address_attributes = Address.last.attributes.select { |k, _| %w(street1 suburb state country).include?(k) }

          expect(address_attributes).to eql({
             'suburb' => '',
            'street1' => 'Some Street',
              'state' => '',
            'country' => ''
          })
        end
      end

      context 'without address attributes' do
        it 'creates a resource' do
          expect { click_button 'Save' }.to change { Resource.count }.by(1)
          expect(page).to have_content('Resource was successfully created.')
        end

        it 'creates an empty address' do
          expect { click_button 'Save' }.to change { Address.count }.by(1)

          address_attributes = Address.last.attributes.select { |k, _| %w(street1 suburb state country).include?(k) }

          expect(address_attributes).to eql({
             'suburb' => '',
            'street1' => '',
              'state' => '',
            'country' => ''
          })
        end
      end

      context 'with invalid attributes' do
        it 'shows an error message' do
          fill_in 'Name', with: ''
          expect { click_button 'Save' }.to change { Address.count }.by(0)

          expect(page).to have_content("Name can't be blank")
        end
      end
    end

    context 'updating a resource' do
      let :resource do
        create(:resource, user: user).tap do |r|
          r.address = create(:address, addressable: r)
        end
      end

      before do
        visit resource_path(resource)
        click_link 'Edit'
      end

      context 'changing the resource attributes' do
        it 'updates the resource' do
          fill_in 'Name', with: 'New Name'
          click_button 'Save'

          expect(page).to have_content('Resource was successfully updated.')
          expect(resource.reload.name).to eql('New Name')
        end
      end

      context 'changing the address attributes' do
        it 'updates the address' do
          fill_in 'Street', with: 'New Street'
          click_button 'Save'

          expect(page).to have_content('Resource was successfully updated.')
          expect(resource.reload.address.street1).to eql('New Street')
        end
      end

      context 'removing all address attributes' do
        it 'updates the address' do
          fill_in 'Street',   with: ''
          fill_in 'Suburb',   with: ''
          fill_in 'State',    with: ''
          fill_in 'Country',  with: ''
          click_button 'Save'

          expect(page).to have_content('Resource was successfully updated.')

          address_attributes = resource.reload.address.attributes.select { |k, _| %w(street1 suburb state country).include?(k) }

          expect(address_attributes).to eql({
             'suburb' => '',
            'street1' => '',
              'state' => '',
            'country' => ''
          })
        end
      end

      context 'with invalid attributes' do
        it 'shows an error message' do
          fill_in 'Name', with: ''
          click_button 'Save'

          expect(page).to have_content("Name can't be blank")
        end
      end
    end
  end
end
