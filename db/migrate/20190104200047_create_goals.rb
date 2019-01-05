class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :year
      t.integer :count

      t.timestamps
    end
  end
end
