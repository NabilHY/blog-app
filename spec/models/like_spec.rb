require 'rails_helper'

RSpec.describe Like, type: :model do
  subject do
    user = User.new(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                    bio: 'Teacher from Mexico.', post_counter: 0)
    post = Post.new(author: user, title: 'Hello', text: 'This is my first post', likes_counter: 0,
                    comment_counter: 0)
    Like.new(author: user, post:)
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'likes_count gets incremented by 1' do
    subject.save
    expect(subject.post.likes_counter).to eq(1)
  end
end
