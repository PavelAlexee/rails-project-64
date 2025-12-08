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

  test 'should load categories for new post' do
    sign_in @user
    get new_post_path
    assert { assigns(:categories).include?(@category) }
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
