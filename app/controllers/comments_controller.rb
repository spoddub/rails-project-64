class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])

    comment = post.comments.build(comment_params.merge(user: current_user))
    comment.parent_id ||= params[:parent_id].presence

    if comment.save
      redirect_to post_path(post), notice: "Комментарий добавлен"
    else
      redirect_to post_path(post), alert: comment.errors.full_messages.to_sentence
    end
  end

  private

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
