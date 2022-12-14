class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'

  validates :name, presence: { strict: true }
  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :recent_posts, ->(user_id) { Post.where(author_id: user_id).order(created_at: :desc).limit(3) }

  def admin?
    role == 'admin'
  end
end
