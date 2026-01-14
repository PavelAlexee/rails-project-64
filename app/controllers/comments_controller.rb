# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: t('.created')
    else
      @comments = @post.comments.roots
      render 'posts/show', status: :unprocessable_content
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
    redirect_to root_path, alert: t('posts.not_found') unless @post
  end

  def comment_params
    params.expect(post_comment: %i[content parent_id])
  end
end
