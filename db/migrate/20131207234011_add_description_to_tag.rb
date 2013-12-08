class AddDescriptionToTag < ActiveRecord::Migration
  def change
    add_column :tags, :description, :string
  end
end
