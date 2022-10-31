require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test 'should get Likes' do
    get comments_Likes_url
    assert_response :success
  end
end
