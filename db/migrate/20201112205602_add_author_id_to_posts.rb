class AddAuthorIdToPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :user_id
    remove_index :posts, name: "index_profiles_on_user_id"
    add_column :posts, :author_id, :integer
    add_index :posts, :author_id
  end
end
