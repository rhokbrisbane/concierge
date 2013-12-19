class RemoveUserIdColumnFromAddresses < ActiveRecord::Migration
  def change
    remove_column :addresses, :user_id
  end
end
