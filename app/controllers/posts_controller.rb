class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_post, only: %i[show edit update destroy]

  def show
  end

  def new
    @post = current_user.posts.build
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def create
    @post = current_user.posts.build(post_params)
    @categories = Category.all

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      @categories = Category.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
