class AddActivityIdToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :activity_id, :integer
  end
end
