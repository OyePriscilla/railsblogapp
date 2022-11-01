require 'rails_helper'

RSpec.describe 'Post show', type: :request do
  before(:each) do
    @first_user = User.create(
      name: 'Priscilla',
      photo: 'https://i.im.ge/2022/10/30/2R6c3h.man.jpg',
      bio: 'Engineer from Nigeria.',
      posts_counter: 2
    )

    @first_post = Post.create(
      author: @first_user,
      title: 'New Post',
      text: 'This is my first test post',
      comments_counter: 0,
      likes_counter: 0
    )

    Comment.new(author: @first_user, post: @first_post, text: 'Hello')
    Comment.new(author: @first_user, post: @first_post, text: 'Hello')

    @users = User.all
  end

  describe 'integration' do
    before(:each) { visit user_post_path(@first_user, @first_post) }

    scenario 'display post title' do
      expect(page).to have_content('New Post')
    end
    scenario 'display post author' do
      expect(page).to have_content @first_post.author.name
    end
    scenario 'display post comments count' do
      expect(page).to have_content("Comments: #{@first_post.comments_counter}")
    end
    scenario 'display post likes count' do
      expect(page).to have_content("Likes: #{@first_post.likes_counter}")
    end
    scenario 'displays post body' do
      expect(page).to have_content @first_post.text
    end
    scenario 'displays post commenters name' do
      @first_post.comments.each do |comment|
        expect(page).to have_content comment.author
      end
    end
    scenario 'displays post commenters text' do
      @first_post.comments.each do |comment|
        expect(page).to have_content comment.text
      end
    end
  end
end
