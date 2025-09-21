# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    comment = build_comment

    if comment.save
      redirect_to post_path(@post), notice: t('flash.comments.created')
    else
      redirect_to post_path(@post), alert: comment.errors.full_messages.to_sentence
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def parent_comment
    pid = params[:parent_id] ||
          params.dig(:comment, :parent_id) ||
          params.dig(:post_comment, :parent_id)
    if defined?(@parent_comment)
      @parent_comment
    else
      @parent_comment = @post.comments.find_by(id: pid)
    end
  end

  def comment_content
    params.dig(:comment, :content) ||
      params.dig(:post_comment, :content) ||
      params[:content]
  end

  def build_comment
    @post.comments.new(
      content: comment_content,
      user: current_user,
      parent: parent_comment
    )
  end
end
