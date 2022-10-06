class AddAdminToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :string, default: "admin"
  end
end
