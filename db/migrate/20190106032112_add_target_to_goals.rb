class AddTargetToGoals < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :target, :integer
  end
end
