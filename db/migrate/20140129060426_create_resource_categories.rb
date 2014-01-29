class CreateResourceCategories < ActiveRecord::Migration
  def change
    create_table :resource_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
