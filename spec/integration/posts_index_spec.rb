require 'rails_helper'

RSpec.describe 'Post index', type: :feature do
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

    Comment.new(author: @first_user, post: @first_post, text: 'Hey whats Heloooo')
    Comment.new(author: @first_user, post: @first_post, text: 'Hi')

    @users = User.all
  end

  describe 'integration' do
    before(:each) { visit user_posts_path(@first_user) }

    scenario 'displays profile picture' do
      expect(page).to have_css("img[src*='#{@first_user.photo}']")
    end

    scenario 'displays username' do
      expect(page).to have_content @first_user.name
    end

    scenario 'displays number of posts' do
      expect(page).to have_content "Number of posts: #{@first_user.posts_counter}"
    end

    scenario 'displays a post first comments' do
      @first_post.recent_comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end

    scenario 'displays number of comments for each post' do
      expect(page).to have_content("Comments: #{@first_post.comments_counter}")
    end

    scenario 'displays number of likes for each post' do
      expect(page).to have_content("Comments: #{@first_post.likes_counter}")
    end

    scenario 'displays pagination' do
      expect(find('.see-all-button')).to be_truthy
    end
  end
end