class CreateUserShares < ActiveRecord::Migration
  def change
    create_table :user_shares do |t|
      t.integer :shared_user_id
      t.integer :sharable_id
      t.string :sharable_type

      t.timestamps
    end
  end
end
