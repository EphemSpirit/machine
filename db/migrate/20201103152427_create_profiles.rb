class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    drop_table :profiles
    create_table :profiles do |t|
      t.integer :user_id
      t.index :user_id
      t.timestamps
    end
  end
end
