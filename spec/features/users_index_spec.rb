require 'rails_helper'

RSpec.describe 'Users index', type: :feature do
  before :each do
    @user1 = User.create!(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Mexico.')
    @user2 = User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Poland.')
  end

  it 'should show all users' do
    visit root_path
    expect(page).to have_content('Lilly')
    expect(page).to have_content('Tom')
  end

  it 'shows the profile picture for each user' do
    visit root_path
    expect(page).to have_css('img[src*="https://unsplash.com/photos/F_-0BxGuVvo"]')
  end

  it 'displays the correct number of posts' do
    visit '/'
    expect(page).to have_content('Number of Posts: 0')
  end

  it 'after clicking on a user, the user profile page is displayed' do
    visit '/'
    click_link @user1.name
    expect(page).to have_current_path user_path(@user1.id)
  end
end
