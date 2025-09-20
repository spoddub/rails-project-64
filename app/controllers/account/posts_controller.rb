module Account
  class PostsController < ApplicationController
    before_action :authenticate_user!
    def index
      @posts = current_user.posts.includes(:category).order(created_at: :desc)
    end
    def new
      @post = Post.new
    end
    def create
      @post = Post.new(post_params)
      @post.creator = current_user
      if post.save
        redirect_to account_posts_path, notice: "Пост создан!"
      end
    end
    private
    def post_params
      params.require(:post).permit(:titile, :body, :category_id)
    end
  end
end
