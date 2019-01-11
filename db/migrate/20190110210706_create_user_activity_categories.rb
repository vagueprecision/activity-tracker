class CreateUserActivityCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :user_activity_categories do |t|
      t.belongs_to :user_activity, null: false, index: true
      t.belongs_to :category, null: false, index: true

      t.timestamps null: false
    end
  end
end
