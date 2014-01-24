require 'spec_helper'

describe 'Categories' do
  context 'as an admin' do
    let!(:user) { find_or_create_user(admin: true) }

    before { authenticate }

    it 'shows all categories' do
      category = create :category

      visit categories_path

      expect(page).to have_content(category.name)
    end

    it 'creates a new category' do
      visit categories_path
      click_link 'New category'

      fill_in 'Name', with: 'Category 1'
      click_button 'Save'

      expect(page).to have_content('Category was successfully created.')
      expect(page).to have_content('Category 1')
    end

    it 'updates a category' do
      category = create :category

      visit edit_category_path(category)

      fill_in 'Name', with: 'New category'
      click_button 'Save'

      expect(page).to have_content('Category was successfully updated.')
      expect(page).to have_content('New category')
    end

    it 'destroys a category' do
      category = create :category

      visit categories_path
      expect(page).to have_content(category.name)

      expect { click_link 'Delete' }.to change { Category.count }.by(-1)

      expect(page).to have_content('Category was successfully removed.')
    end
  end
end
