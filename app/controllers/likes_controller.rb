class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    like = post.post_likes.find_or_initialize_by(user: current_user)

    if like.persisted? || like.save
      redirect_to post_path(post), notice: "Лайк поставлен"
    else
      redirect_to post_path(post), alert: like.errors.full_messages.to_sentence
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    like = post.post_likes.find_by(user: current_user)
    like&.destroy
    redirect_to post_path(post), notice: "Лайк убран"
  end
end
