class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.post_comments.build(comment_params.merge(user: current_user))

    if params[:parent_id].present?
      parent = @post.post_comments.find_by(id: params[:parent_id])
      @comment.parent = parent if parent
    end
    if @comment.save
      redirect_to post_path(@post, anchor: dom_id(@comment)), notice: "Комментарий добавлен"
    else
      @comment.errors.add(:base, "Не удалось сохранить комментарий") if @comment.errors.empty?
      render "posts/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:post_comments).permit(:content)
  end
end
