class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.integer :friender_id
      t.integer :friendee_id
      t.index :friender_id
      t.index :friendee_id

      t.timestamps
    end
  end
end
