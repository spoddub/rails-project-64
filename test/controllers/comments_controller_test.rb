require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = User.create!(email: Faker::Internet.unique.email, password: "password123")
    @category = Category.create!(name: Faker::Lorem.unique.word)
    @post = Post.create!(title: "Title", body: "Body", category: @category, creator: @user)
  end

  test "POST /posts/:post_id/comments requires auth" do
    post post_comments_path(@post), params: { post_comment: { content: "Hi" } }
    assert_response :redirect
    assert { response.redirect_url.include?("sign_in") }
  end

  test "POST /posts/:post_id/comments creates root comment" do
    sign_in @user
    assert_difference -> { PostComment.count }, +1 do
      post post_comments_path(@post), params: { post_comment: { content: "Root" } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert { @post.post_comments.exists?(content: "Root") }
  end

  test "POST /posts/:post_id/comments creates child comment" do
    sign_in @user
    parent = @post.post_comments.create!(content: "Parent", user: @user)

    assert_difference -> { PostComment.count }, +1 do
      post post_comments_path(@post), params: {
        post_comment: { content: "Child" },
        parent_id: parent.id
      }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success

    child = @post.post_comments.find_by(content: "Child")
    assert { child.parent == parent }
  end
end
