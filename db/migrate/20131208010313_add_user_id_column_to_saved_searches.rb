class AddUserIdColumnToSavedSearches < ActiveRecord::Migration
  def change
    add_column :saved_searches, :user_id, :integer
  end
end
