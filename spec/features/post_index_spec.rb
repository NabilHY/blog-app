require 'rails_helper'

RSpec.describe 'Posts index', type: :feature do
  before :each do
    @user1 = User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Poland.')
    @user2 = User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Poland.')
    @first_post = Post.create(author: @user1, title: 'Hello', text: 'Hello World')
    5.times do |_i|
      Comment.create(post: @first_post, author: @user2, text: 'Hello there')
    end
    visit user_posts_path(@user1)
  end

  it 'displays the user profile picture' do
    expect(page).to have_css('img[src*="https://unsplash.com/photos/F_-0BxGuVvo"]')
  end

  it 'displays the user username' do
    expect(page).to have_content(@user1.name)
  end

  it 'diplays the number of posts the user has written' do
    expect(page).to have_content('Number of Posts: 1')
  end

  it 'displays the post title' do
    expect(page).to have_content(@first_post.title)
  end

  it "displays the post's body" do
    expect(page).to have_content(@first_post.text)
  end

  it 'displays how many comments on a post' do
    expect(page).to have_content('Comments: 5')
  end

  it 'displays how many likes on a post' do
    expect(page).to have_content('Likes: 0')
  end

  it "redirects to the post's show page when I click on a post" do
    click_link 'Post #'
    expect(page).to have_current_path user_post_path(@user1.id, @first_post.id)
  end
end
