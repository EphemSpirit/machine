class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :commenter_id, foreign_key: true
      t.integer :commented_post_id, foreign_key: true

      t.timestamps
    end
  end
end
