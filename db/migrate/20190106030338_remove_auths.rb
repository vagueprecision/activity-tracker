class RemoveAuths < ActiveRecord::Migration[5.2]
  def change
    drop_table :auths
  end
end
