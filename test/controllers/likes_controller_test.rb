require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email: Faker::Internet.email, password: "password")
    sign_in @user

    @category = Category.create!(name: SecureRandom.hex(4))
    @post = Post.create!(title: "T", body: "B", category: @category, creator: @user)
  end

  test "POST /posts/:post_id/like creates like" do
    assert_difference -> { PostLike.count }, +1 do
      post post_like_path(@post)
    end
    assert_redirected_to post_path(@post)
  end

  test "POST /posts/:post_id/like does not duplicate" do
    PostLike.create!(user: @user, post: @post)
    assert_no_difference -> { PostLike.count } do
      post post_like_path(@post)
    end
    assert_redirected_to post_path(@post)
  end

  test "DELETE /posts/:post_id/like removes like" do
    PostLike.create!(user: @user, post: @post)
    assert_difference -> { PostLike.count }, -1 do
      delete post_like_path(@post)
    end
    assert_redirected_to post_path(@post)
  end

  test "requires auth" do
    sign_out @user
    assert_no_difference -> { PostLike.count } do
      post post_like_path(@post)
    end
    assert_response :redirect
  end
end
