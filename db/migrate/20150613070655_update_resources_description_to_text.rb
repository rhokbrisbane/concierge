class UpdateResourcesDescriptionToText < ActiveRecord::Migration
  def change
    change_column :resources, :description, :text
  end
end
