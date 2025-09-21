# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  # GET /posts/:id
  def show
    @post = Post.find(params[:id])
    @comment = PostComment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts
  def create
    @post = Post.new(post_params.merge(creator: current_user))

    if @post.save
      redirect_to post_path(@post), notice: t('flash.posts.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
