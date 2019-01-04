class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.int :year
      t.int :count

      t.timestamps
    end
  end
end
