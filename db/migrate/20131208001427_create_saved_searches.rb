class CreateSavedSearches < ActiveRecord::Migration
  def change
    create_table :saved_searches do |t|
      t.string :name

      t.timestamps
    end
  end
end
