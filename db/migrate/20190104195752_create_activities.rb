class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name, null: false, limit: 36

      t.timestamps null: false
    end
  end
end
