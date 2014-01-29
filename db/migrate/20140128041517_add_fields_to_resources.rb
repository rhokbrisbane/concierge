class AddFieldsToResources < ActiveRecord::Migration
  def up
    add_column     :resources, :description, :string
    add_attachment :resources, :avatar
    add_column     :resources, :region, :string
  end

  def down
    remove_column     :resources, :region
    remove_attachment :resources, :avatar
    remove_column     :resources, :description
  end
end
