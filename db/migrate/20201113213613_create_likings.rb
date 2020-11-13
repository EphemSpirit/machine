class CreateLikings < ActiveRecord::Migration[6.0]
  def change
    create_table :likings do |t|
      t.integer :liker_id, foreign_key: true
      t.integer :liked_post_id, foreign_key: true

      t.timestamps
    end
  end
end
