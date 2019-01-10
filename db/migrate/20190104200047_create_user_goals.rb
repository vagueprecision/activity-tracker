class CreateUserGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :user_goals do |t|
      t.integer :user_id, null: false
      t.integer :activity_id, null: false
      t.integer :year, null: false
      # t.datetime :starts_at, null: false
      # t.datetime :ends_at, null: false
      t.integer :count, null: false, default: 0
      t.integer :target, null: false
      # t.string :frequency, null: false, limit: 36 - will likely need refactoring to make this work correctly

      t.timestamps null: false

      add_foreign_key :user_goals, :users, index: true
      add_foreign_key :user_goals, :activities, index: true
    end
  end
end
