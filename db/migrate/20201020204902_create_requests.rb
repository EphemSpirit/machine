class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :accepted
      t.integer :user_id
      t.index :sender_id
      t.index :receiver_id

      t.timestamps
    end
  end
end
