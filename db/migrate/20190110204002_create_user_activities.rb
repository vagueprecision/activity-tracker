class CreateUserActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :user_activities do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :activity, null: false, index: true
      t.datetime :performed_at, null: false

      t.timestamps null: false

      add_foreign_key :user_activities, :users, index: true
      add_foreign_key :user_activities, :activities, index: true
    end
  end
end
