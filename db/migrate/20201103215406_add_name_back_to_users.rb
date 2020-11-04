class AddNameBackToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    remove_column :profiles, :name
  end
end
