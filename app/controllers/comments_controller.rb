# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = build_comment
    comment.save!
    redirect_to post_path(comment.post), notice: t('flash.comments.created')
  end

  private

  def build_comment
    post   = Post.find(params[:post_id])
    parent = post.comments.find_by(id: params[:parent_id])
    post.comments.new(
      content: params.require(:comment)[:content],
      user: current_user,
      parent: parent
    )
  end
end
