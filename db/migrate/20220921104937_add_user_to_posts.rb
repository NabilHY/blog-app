class AddUserToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :user, :integer
    add_index :posts, :user
  end
end
