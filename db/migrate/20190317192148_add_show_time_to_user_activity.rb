class AddShowTimeToUserActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :user_activities, :show_time, :boolean, null: false, :default => false
  end
end
