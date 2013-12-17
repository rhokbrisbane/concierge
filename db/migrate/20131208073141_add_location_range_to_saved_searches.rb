class AddLocationRangeToSavedSearches < ActiveRecord::Migration
  def change
    add_column :saved_searches, :location_range, :integer
  end
end
