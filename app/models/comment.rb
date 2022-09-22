class Comment < ApplicationRecord
  belongs_to :post, class_name: 'Post'
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  after_save :update_comments_counter
  
  def update_comments_counter
    post.update(comment_counter: post.comments.count)
  end  
end
