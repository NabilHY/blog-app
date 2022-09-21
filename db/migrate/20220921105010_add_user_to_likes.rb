class AddUserToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :user, :integer
    add_index :likes, :user
  end
end
