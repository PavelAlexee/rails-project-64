# frozen_string_literal: true

require 'test_helper'

class PostsControllerCreationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @category = categories(:one)
    @user = users(:one)
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

  test 'should load categories for new post' do
    sign_in @user
    get new_post_path
    assert { assigns(:categories).include?(@category) }
  end

  test 'should redirect create when not authenticated' do
    assert_no_difference('Post.count') do
      post posts_path, params: {
        post: {
          title: 'New Post',
          body: 'New post body with enough characters',
          category_id: @category.id
        }
      }
    end
    assert_redirected_to new_user_session_path
  end

  test 'should create post with valid params' do
    sign_in @user
    assert_difference('Post.count', 1) do
      post posts_path, params: {
        post: {
          title: 'New Post Title',
          body: 'New post body content here with enough characters',
          category_id: @category.id
        }
      }
    end
    assert_redirected_to post_path(Post.last)
  end

  test 'should create post with correct attributes' do
    sign_in @user
    post posts_path, params: {
      post: {
        title: 'New Post Title',
        body: 'New post body content here with enough characters',
        category_id: @category.id
      }
    }

    assert { Post.last.creator == @user }
    assert { Post.last.title == 'New Post Title' }
  end

  test 'should not create post with invalid params' do
    sign_in @user
    assert_no_difference('Post.count') do
      post posts_path, params: {
        post: {
          title: '',
          body: 'short',
          category_id: @category.id
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test 'should load categories when post creation fails' do
    sign_in @user
    post posts_path, params: {
      post: {
        title: '',
        body: 'short',
        category_id: @category.id
      }
    }
    assert { assigns(:categories).include?(@category) }
  end
end
