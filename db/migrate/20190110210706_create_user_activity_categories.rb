class CreateUserActivityCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :user_activity_categories do |t|
      t.integer :user_activity_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
