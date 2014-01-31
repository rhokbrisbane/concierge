require 'spec_helper'

describe 'Resource Categories' do
  context 'as an admin' do
    let!(:user) { find_or_create_user(admin: true) }

    before { authenticate }

    it 'shows all categories' do
      category = create :resource_category

      visit resource_categories_path

      expect(page).to have_content(category.name)
    end

    it 'creates a new category' do
      visit resource_categories_path
      click_link 'New category'

      fill_in 'Name', with: 'Category 1'
      click_button 'Save'

      expect(page).to have_content('Category was successfully created.')
      expect(page).to have_content('Category 1')
    end

    it 'updates a category' do
      category = create :resource_category

      visit edit_resource_category_path(category)

      fill_in 'Name', with: 'New category'
      click_button 'Save'

      expect(page).to have_content('Category was successfully updated.')
      expect(page).to have_content('New category')
    end
  end
end
