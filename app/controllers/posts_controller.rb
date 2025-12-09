# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :check_authorization, only: %i[edit update destroy]
  before_action :set_categories, only: %i[new edit create update]

  def show
    @comment = @post.comments.build
    @comments = @post.comments.roots

    @user_like = @post.likes.find_by(user: current_user) if user_signed_in?
  end

  def new
    @post = current_user.posts.build
  end

  def edit; end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path notice: t('.destroyed')
  end

  private

  def set_post
    @post = Post.find(params[:id])
    redirect_to root_path, alert: t('.not_found') unless @post
  end

  def set_categories
    @categories = Category.all
  end

  def post_params
    params.expect(post: %i[title body category_id])
  end

  def check_authorization
    redirect_to root_path, alert: t('.no_permission') unless @post.creator == current_user
  end
end
