class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.datetime :performed_at
      t.string :name

      t.timestamps
    end
  end
end
