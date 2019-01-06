class AddFrequencyToGoals < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :frequency, :string
  end
end
