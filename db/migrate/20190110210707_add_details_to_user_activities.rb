class AddDetailsToUserActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :user_activities, :details, :text
  end
end
