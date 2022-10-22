require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Validation for the Comment model' do
    before(:example) do
      @user = User.new(name: 'Priscilla', photo: 'photo_url', bio: 'Software Engineer')
      @post = Post.new(author: @user, title: 'Ruby on Rails', comments_counter: 0, likes_counter: 0)
      @comment = Comment.new(text: 'Nice Framework', author_id: @user.id, post_id: @post.id)
    end

    it 'if there is a text comment' do
      @comment.text = nil
      expect(@comment).to_not be_valid
    end

    it 'test if author_id is integer' do
      @comment.author_id = 'string'
      expect(@comment).to_not be_valid
    end

    it 'test if post_id is integer' do
      @comment.post_id = 'string'
      expect(@comment).to_not be_valid
    end
  end
end
