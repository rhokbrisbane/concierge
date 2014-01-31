class RenameTagCategoriesTable < ActiveRecord::Migration
  def change
    rename_table :categories, :tag_categories
  end
end
