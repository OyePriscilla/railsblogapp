require 'rails_helper'

RSpec.describe 'User show', type: :feature do
  before(:each) do
    @first_user = User.create(
      name: 'Priscilla',
      photo: 'https://i.im.ge/2022/10/30/2R6c3h.man.jpg',
      bio: 'Engineer from Nigeria.',
      posts_counter: 4
    )

    User.create(
      name: 'Sidney',
      photo: 'https://i.im.ge/2022/10/30/2R6RqY.woman.jpg',
      bio: 'Engineer from Kenya.',
      posts_counter: 2
    )

    @first_post = Post.create(
      author: @first_user,
      title: 'Hello',
      text: 'This is my first post',
      comments_counter: 0,
      likes_counter: 0
    )

    Post.create(
      author: @first_user,
      title: 'Hello',
      text: 'This is my second test post',
      comments_counter: 0,
      likes_counter: 0
    )

    @users = User.all
  end

  describe 'integration' do
    before(:each) { visit user_path @first_user }

    scenario 'displays profile picture' do
      expect(page).to have_css("img[src*='#{@first_user.photo}']")
    end

    scenario 'display username' do
      expect(page).to have_content @first_user.name
    end

    scenario 'display number of posts' do
      expect(page).to have_content "Number of posts: #{@first_user.posts_counter}"
    end

    scenario 'display bio' do
      expect(page).to have_content @first_user.bio
    end

    scenario 'display  first three posts' do
      @first_user.recent_posts.each do |post|
        expect(page).to have_content post.text
      end
    end

    scenario 'display button to see all user posts' do
      within '.see-all-button' do
        expect(page).to have_content 'See all posts'
      end
    end

    scenario 'button redirects to posts index page' do
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@first_user)
    end
  end
end
