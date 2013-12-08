class AddDescriptionToResources < ActiveRecord::Migration
  def change
    add_column :resources, :description, :string
  end
end
