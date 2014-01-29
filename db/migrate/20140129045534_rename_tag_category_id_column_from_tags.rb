class RenameTagCategoryIdColumnFromTags < ActiveRecord::Migration
  def change
    rename_column :tags, :category_id, :tag_category_id
  end
end
