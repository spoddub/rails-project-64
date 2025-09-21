# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user     = User.create!(email: 'u@example.com', password: 'secret123')
    @category = Category.create!(name: 'Tech')
    @post     = Post.create!(title: 'Title', body: 'Body', category: @category, creator: @user)
  end

  test 'POST /posts/:post_id/like creates like' do
    sign_in @user
    assert_difference -> { PostLike.count }, +1 do
      post post_likes_path(@post)
    end
    assert_redirected_to post_path(@post)
  end

  test 'POST /posts/:post_id/like does not duplicate' do
    sign_in @user
    @post.post_likes.create!(user: @user)

    assert_no_difference -> { PostLike.count } do
      post post_likes_path(@post)
    end
    assert_redirected_to post_path(@post)
  end

  test 'DELETE /posts/:post_id/like removes like' do
    sign_in @user
    @post.post_likes.create!(user: @user)

    assert_difference -> { PostLike.count }, -1 do
      delete post_like_path(@post) # destroy у singular resource
    end
    assert_redirected_to post_path(@post)
  end

  test 'requires auth' do
    post post_likes_path(@post)
    assert_response :redirect
  end
end
