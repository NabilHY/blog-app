class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :likes, foreign_key: 'post_id'
  has_many :comments, foreign_key: 'post_id'
  after_save :update_post_counter

  scope :update_post_counter, ->(user_id) { User.find(user_id).update(post_counter: User.find(user_id).posts.count) }
  scope :five_recent_comment, ->(post) { Comment.where(post_id: post).order(created_at: :desc).limit(3) }


end
