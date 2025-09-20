class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @comment = PostComment.new
  end
end
