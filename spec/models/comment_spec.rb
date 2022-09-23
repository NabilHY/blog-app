require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject do
    user = User.new(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                    bio: 'Teacher from Mexico.', post_counter: 0)
    post = Post.new(author: user, title: 'Hello', text: 'This is my first post', likes_counter: 0,
                    comment_counter: 0)
    Comment.new(post:, author: user, text: 'Hi Tom!')
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'comment_counter gets incremented by 1' do
    expect(subject.post.comment_counter).to eq(1)
  end
end
