require 'rails_helper'

RSpec.describe 'Posts show', type: :feature do
  before :each do
    @user1 = User.create!(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Mexico.')
    @user2 = User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Poland.')
    @post = Post.create(author: @user1, title: 'Hello', text: 'Hello World')
    Comment.create(post: @post, author: @user2, text: 'Hello there')
    Comment.create(post: @post, author: @user2, text: 'Hello there')
    visit user_post_path(@user1.id, @post.id)
  end

  it "show the post's title" do
    expect(page).to have_content(@post.title)
  end

  it 'show who wrote the post' do
    expect(page).to have_content(@user1.name)
  end

  it 'shows the comment count for the post' do
    expect(page).to have_content('Comments: 2')
  end

  it 'shows the likes count for the post' do
    expect(page).to have_content('Likes: 0')
  end

  it 'shows the post body' do
    expect(page).to have_content(@post.text)
  end

  it 'shows the username of each comments' do
    expect(page).to have_content(@user2.name)
  end

  it 'show the comment the commentator left' do
    expect(page).to have_content('Hello there')
  end
end
