class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :likes, foreign_key: 'post_id'
  has_many :comments, foreign_key: 'post_id'
  after_save :update_posts_counter

  scope :five_recent_comments, ->(post) { Comment.where(post_id: post).order(created_at: :desc).limit(3) }

  def update_posts_counter
    author.update(post_counter: author.posts.count)
  end
end
