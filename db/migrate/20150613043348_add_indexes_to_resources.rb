class AddIndexesToResources < ActiveRecord::Migration
  def change
    add_index :resources, :name
    add_index :resources, :url
    add_index :resources, :facebook
    add_index :resources, :twitter
    add_index :resources, :description
  end
end
