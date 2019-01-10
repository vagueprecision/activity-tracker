class CreateUserActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :user_activities do |t|
      t.integer :user_id, null: false
      t.integer :activity_id, null: false
      t.datetime :performed_at, null: false

      t.timestamps null: false

      add_foreign_key :user_activities, :users, index: true
      add_foreign_key :user_activities, :activities, index: true
    end
  end
end
