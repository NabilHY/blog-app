require 'rails_helper'

RSpec.describe 'Users show', type: :feature do
  before :each do
    @user1 = User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Poland.')
    5.times do |i|
      Post.create!(author: @user1, title: "Post #{i}", text: 'Hello World!')
    end
    visit user_path(@user1.id)
  end

  it 'displays the user profile picture' do
    expect(page).to have_css('img[src*="https://unsplash.com/photos/F_-0BxGuVvo"]')
  end

  it 'displays the username' do
    expect(page).to have_content('Tom')
  end

  it 'displays the user bio' do
    expect(page).to have_content('Teacher from Poland.')
  end

  it 'displays the user bio' do
    expect(page).to have_content('Teacher from Poland.')
  end

  it "displaysthe user's first 3 posts" do
    expect(page).to have_content('Post 4')
    expect(page).to have_content('Post 3')
    expect(page).to have_content('Post 2')
    expect(page).not_to have_content('Post 1')
  end

  it "has a button that links to the user's posts" do
    expect(page).to have_link('See all posts', href: user_posts_path(@user1.id))
  end

  it "should redirect to the user's posts page when the button is clicked" do
    click_link 'See all posts'
    expect(page).to have_current_path user_posts_path(@user1.id)
  end
end
