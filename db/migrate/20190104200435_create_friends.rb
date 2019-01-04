class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.int :user_id
      t.string :name

      t.timestamps
    end
  end
end
