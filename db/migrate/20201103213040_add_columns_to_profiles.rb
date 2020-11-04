class AddColumnsToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :name, :string
    add_column :profiles, :birthday, :datetime
    add_column :profiles, :age, :integer
    add_column :profiles, :bio, :text
  end
end
