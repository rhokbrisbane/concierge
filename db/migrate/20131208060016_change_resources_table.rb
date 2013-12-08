class ChangeResourcesTable < ActiveRecord::Migration
  def change
    remove_column :resources, :content
    remove_column :resources, :description

    add_column :resources, :category, :string
    add_column :resources, :url,      :string
    add_column :resources, :phone,    :string
    add_column :resources, :facebook, :string
    add_column :resources, :twitter,  :string
  end
end
