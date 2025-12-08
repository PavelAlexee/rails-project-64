# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @john = users(:one)
    @jane = users(:two)
    @post = posts(:one)
    @category = categories(:one)
    @root_comment = post_comments(:root_comment)
    @parent_comment = post_comments(:with_comments)
  end

  test 'should redirect create when not authenticated' do
    assert_no_difference('PostComment.count') do
      post post_comments_path(@post), params: {
        post_comment: { content: 'New comment content' }
      }
    end
    assert_redirected_to new_user_session_path
  end

  test 'should create comment with valid params' do
    sign_in @john
    assert_difference('PostComment.count', 1) do
      post post_comments_path(@post), params: {
        post_comment: {
          content: 'This is a new comment with sufficient content'
        }
      }
    end
    assert_redirected_to post_path(@post)
    assert_equal 'Комментарий успешно добавлен.', flash[:notice]
  end

  test 'should create comment with correct attributes' do
    sign_in @john
    post post_comments_path(@post), params: {
      post_comment: {
        content: 'This is a new comment with sufficient content'
      }
    }

    new_comment = PostComment.last

    assert_equal @john, new_comment.user
    assert_equal @post, new_comment.post
    assert_equal '/', new_comment.ancestry
  end

  test 'should create nested comment with parent_id' do
    sign_in @jane
    assert_difference('PostComment.count', 1) do
      post post_comments_path(@post), params: {
        post_comment: {
          content: 'This is a reply to another comment',
          parent_id: @parent_comment.id
        }
      }
    end
    assert_redirected_to post_path(@post)
  end

  test 'should create nested comment with correct parent' do
    sign_in @jane
    post post_comments_path(@post), params: {
      post_comment: {
        content: 'This is a reply to another comment',
        parent_id: @parent_comment.id
      }
    }

    new_comment = PostComment.last

    assert_equal @parent_comment, new_comment.parent
    assert_equal "/#{@parent_comment.id}/", new_comment.ancestry
  end

  test 'should not create comment with empty content' do
    sign_in @john
    assert_no_difference('PostComment.count') do
      post post_comments_path(@post), params: {
        post_comment: { content: '' }
      }
    end
    assert_response :unprocessable_entity
  end

  test 'should render posts/show when comment creation fails' do
    sign_in @john
    post post_comments_path(@post), params: {
      post_comment: { content: '' }
    }

    assert_template 'posts/show'
    assert_not_nil assigns(:comments)
  end

  test 'should handle non-existent post for create' do
    sign_in @john
    assert_no_difference('PostComment.count') do
      post post_comments_path(999_999), params: {
        post_comment: { content: 'Valid content' }
      }
    end
    assert_response :not_found
  end
end
