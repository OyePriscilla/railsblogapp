require 'rails_helper'

RSpec.describe 'User index', type: :feature do
  before(:each) do
    @first_user = User.create(
      name: 'Priscilla',
      photo: 'https://i.im.ge/2022/10/30/2R6c3h.man.jpg',
      bio: 'Pastor from Nigeria.',
      posts_counter: 4
    )

    User.create(
      name: 'Sidney',
      photo: 'https://i.im.ge/2022/10/30/2R6RqY.woman.jpg',
      bio: 'Engineer from Kenya.',
      posts_counter: 2
    )

    @users = User.all
  end

  describe 'integration' do
    before(:each) { visit users_path }

    scenario 'shows the username of all other users' do
      @users.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    scenario 'displays profile picture for each user' do
      @users.each do |user|
        expect(page).to have_css("img[src*='#{user.photo}']")
      end
    end

    scenario 'displays number of posts each user has written' do
      @users.each do |user|
        expect(page).to have_content "Number of posts: #{user.posts_counter}"
      end
    end
  end
end
