class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :longitude
      t.string :latitude
      t.string :suburb
      t.string :postcode
      t.string :street1
      t.string :street2
      t.string :state
      t.string :country
      t.references :addressable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
