class Account::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.where(creator: current_user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(creator: current_user))

    if @post.save
      redirect_to post_path(@post), notice: 'Пост создан'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
