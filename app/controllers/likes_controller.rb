# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])

    @post.likes.find_or_create_by(user: current_user)
    redirect_to @post
  end

  def destroy
    like = PostLike.find_by(id: params[:id], user: current_user)
    post = Post.find(params[:post_id])

    like&.destroy
    redirect_to post
  end
end
