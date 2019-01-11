class CreateUserActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :user_activities do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :activity, null: false, index: true
      t.decimal :perform_count, null: false, precision: 8, scale: 2
      t.datetime :performed_at, null: false

      t.timestamps null: false
    end
  end
end
