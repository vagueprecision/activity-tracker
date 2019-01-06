class AddActivityIdToGoals < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :activity_id, :integer
  end
end
