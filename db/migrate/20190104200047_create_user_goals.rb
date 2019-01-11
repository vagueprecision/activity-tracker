class CreateUserGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :user_goals do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :activity, null: false, index: true
      t.integer :year, null: false
      # t.datetime :starts_at, null: false
      # t.datetime :ends_at, null: false
      t.decimal :count, null: false, precision: 8, scale: 2, default: 0
      t.decimal :target, null: false, precision: 8, scale: 2
      # t.string :frequency, null: false, limit: 36 - will likely need refactoring to make this work correctly

      t.timestamps null: false
    end
  end
end
