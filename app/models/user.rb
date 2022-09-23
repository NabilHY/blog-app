class User < ApplicationRecord
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'

  validates :name, presence: { strict: true }
  scope :recent_posts, ->(user_id) { Post.where(author_id: user_id).order(created_at: :desc).limit(3) }
end
