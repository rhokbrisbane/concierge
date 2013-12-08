class CreateGuardianships < ActiveRecord::Migration
  def change
    create_table :guardianships do |t|
      t.integer :kid_id
      t.integer :user_id

      t.timestamps
    end
  end
end
