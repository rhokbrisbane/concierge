class CreateGroupShares < ActiveRecord::Migration
  def change
    create_table :group_shares do |t|
      t.integer :shared_group_id
      t.integer :sharable_id
      t.string :sharable_type

      t.timestamps
    end
  end
end
