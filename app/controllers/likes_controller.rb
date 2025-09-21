class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    current_user.post_likes.find_or_create_by!(post: post)
    redirect_to post_path(post), notice: 'Пост понравился'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to post_path(post), alert: e.record.errors.full_messages.to_sentence
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.post_likes.where(post: post).destroy_all
    redirect_to post_path(post), notice: 'Лайк удалён'
  end
end
