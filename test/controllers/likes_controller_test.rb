# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @post = posts(:one)
    @like = post_likes(:one)
  end

  test 'should create like when authenticated' do
    sign_in @user

    post_without_like = posts(:two)

    assert_difference('PostLike.count', 1) do
      post post_likes_path(post_without_like)
    end

    assert_redirected_to post_path(post_without_like)
  end

  test 'should destroy like when authenticated' do
    sign_in @user
    post post_likes_path(@post)
    like = PostLike.last

    assert_difference('PostLike.count', -1) do
      delete post_like_path(@post, like)
    end

    assert_redirected_to post_path(@post)
  end

  test 'should not destroy like of another user' do
    other_user = users(:two)
    sign_in other_user
    like = post_likes(:one)

    delete post_like_path(@post, like)

    assert_response :redirect

    assert { PostLike.exists?(like.id) }
  end
end
