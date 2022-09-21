class AddPostToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :post, :integer
    add_index :likes, :post
  end
end
