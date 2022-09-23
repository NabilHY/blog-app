require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'name is not blank' do
    expect(subject.name).to eq('John Doe')
  end

  it 'post_counter is an integer' do
    Post.new do |post|
      post.title = 'Hello World'
      post.text = 'This is my first post'
      post.author_id = subject.id
      post.save
    end
    expect(subject.post_counter).to be_an(Integer)
  end

  it 'blank name raises error' do
    subject.name = ''
    expect { subject.save! }.to raise_error(ActiveModel::StrictValidationFailed)
  end

  it 'post_counter thats not an integer raises error' do
    subject.post_counter = 'a'
    expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'recent posts returns the last 3 posts' do
    5.times do |i|
      Post.new do |post|
        post.title = "Post #{i}"
        post.text = "This is post #{i}"
        post.author_id = subject.id
        post.save
      end
    end
    expect(User.recent_posts(subject.id).length).to eq(3)
  end
end
