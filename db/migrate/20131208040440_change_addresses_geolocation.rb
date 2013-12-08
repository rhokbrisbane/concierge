class ChangeAddressesGeolocation < ActiveRecord::Migration
  def change
    remove_column :addresses, :latitude, :string
    remove_column :addresses, :longitude, :string

    add_column :addresses, :latitude, :float
    add_column :addresses, :longitude, :float
  end
end
