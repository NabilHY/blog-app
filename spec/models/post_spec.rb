require 'rails_helper'
require 'ffi'

RSpec.describe Post, type: :model do
  subject do
    user = User.new(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                    bio: 'Teacher from Mexico.', post_counter: 0)
    Post.new(author: user, title: 'Hello', text: 'This is my first post', likes_counter: 0, comment_counter: 0)
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'title is not blank' do
    expect(subject.title).to eq('Hello')
  end

  it 'comment_counter is an integer' do
    user = User.new(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    Comment.new(post: subject, author: user, text: 'Hi Tom!')
    expect(subject.comment_counter).to be_an(Integer)
  end

  it 'blank title raises error' do
    subject.title = ''
    expect { subject.save! }.to raise_error(ActiveModel::StrictValidationFailed)
  end

  it 'title is too short' do
    subject.title = 'Hi'
    expect(subject).to_not be_valid
  end

  it 'title is too long' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'comment_counter thats not an integer raises error' do
    subject.comment_counter = 'a'
    expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'likes_counter thats not an integer raises an error' do
    subject.likes_counter = 'a'
    expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'five_recent_comments scope returns the last 5 comments' do
    7.times do |i|
      user = User.new(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                      bio: 'Teacher from Mexico.')
      Comment.new do |comment|
        comment.text = "Comment #{i}"
        comment.post = subject
        comment.author = user
        comment.save
      end
    end
    expect(Post.five_recent_comments(subject.id).length).to eq(5)
  end

  it 'update_posts_counter updates the post_counter of the author' do
    user = User.new(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                    bio: 'Teacher from Mexico.', post_counter: 0)
    Post.new(author: user, title: 'Hello', text: 'This is my first post', likes_counter: 0, comment_counter: 0)
    user.increment!(:post_counter)
    expect(user.post_counter).to eq(1)
  end
end
