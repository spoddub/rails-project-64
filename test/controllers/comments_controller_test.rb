# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user     = User.create!(email: 'c@example.com', password: 'secret123')
    @category = Category.create!(name: 'Books')
    @post     = Post.create!(title: 'Title', body: 'Body', category: @category, creator: @user)
  end

  test 'POST /posts/:post_id/comments requires auth' do
    assert_no_difference -> { PostComment.count } do
      post post_comments_path(@post), params: { post_comment: { content: 'Hi' } }
    end
    assert_response :redirect
  end

  test 'POST /posts/:post_id/comments creates root comment' do
    sign_in @user
    assert_difference -> { @post.comments.count }, +1 do
      post post_comments_path(@post), params: { post_comment: { content: 'Root' } }
    end
    assert_redirected_to post_path(@post)
  end

  test 'POST /posts/:post_id/comments creates child comment' do
    sign_in @user
    parent = @post.comments.create!(user: @user, content: 'Parent')

    assert_difference -> { @post.comments.count }, +1 do
      post post_comments_path(@post),
           params: { post_comment: { content: 'Child', parent_id: parent.id } }
    end

    child = @post.comments.order(:created_at).last
    assert { child.parent == parent }
  end
end
