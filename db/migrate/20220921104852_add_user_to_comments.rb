class AddUserToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :user, :integer
    add_index :comments, :user
  end
end
