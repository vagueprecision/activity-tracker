class AddUserIdToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :user_id, :integer
  end
end
