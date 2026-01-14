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

  test 'should redirect new when not authenticated' do
    get new_post_path

    assert_redirected_to new_user_session_path
  end

  test 'should get new when authenticated' do
    sign_in @user
    get new_post_path

    assert_response :success
  end

  test 'should build new post when authenticated' do
    sign_in @user
    get new_post_path
    assert { assigns(:post).is_a?(Post) }
    assert { assigns(:post).new_record? }
  end
end
