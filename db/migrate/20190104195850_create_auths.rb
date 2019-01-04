class CreateAuths < ActiveRecord::Migration[5.2]
  def change
    create_table :auths do |t|
      t.string :name
      t.string :principal

      t.timestamps
    end
  end
end
