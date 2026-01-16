# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @category = categories(:one)
    @user = users(:one)
    @post = posts(:one)
  end

  test 'should show post' do
    get post_path(@post)

    assert_response :success
  end

  test 'should redirect destroy when not authenticated' do
    assert_no_difference('Post.count') do
      delete post_path(@post)
    end
    assert_redirected_to new_user_session_path
  end

  test 'should destroy post' do
    sign_in @user
    assert_difference('Post.count', -1) do
      delete post_path(@post)
    end
    assert_redirected_to root_url(notice: 'Пост успешно удален.')
  end
end
