# frozen_string_literal: true

require 'test_helper'

class PostsControllerUpdateTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @category = categories(:one)
    @user = users(:one)
    @post = posts(:one)
  end
  test 'should redirect edit when not authenticated' do
    get edit_post_path(@post)

    assert_redirected_to new_user_session_path
  end

  test 'should get edit when authenticated' do
    sign_in @user
    get edit_post_path(@post)

    assert_response :success
  end

  test 'should load post for edit' do
    sign_in @user
    get edit_post_path(@post)
    assert { assigns(:post) == @post }
  end

  test 'should load categories for edit' do
    sign_in @user
    get edit_post_path(@post)
    assert { assigns(:categories).include?(@category) }
  end

  test 'should redirect update when not authenticated' do
    patch post_path(@post), params: {
      post: { title: 'Updated Title' }
    }

    assert_redirected_to new_user_session_path
    assert { @post.reload.title == 'First Post' }
  end

  test 'should update post with valid params' do
    sign_in @user
    patch post_path(@post), params: {
      post: {
        title: 'Updated Title',
        body: 'Updated body content here with enough characters'
      }
    }

    assert_redirected_to post_path(@post)
    assert { @post.reload.title == 'Updated Title' }
  end

  test 'should not update post with invalid params' do
    sign_in @user
    patch post_path(@post), params: {
      post: {
        title: '',
        body: 'short'
      }
    }

    assert_response :unprocessable_entity
  end

  test 'should load categories when post update fails' do
    sign_in @user
    patch post_path(@post), params: {
      post: {
        title: '',
        body: 'short'
      }
    }
    assert { assigns(:categories).include?(@category) }
  end
end
