require "test_helper"
class Account::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email: Faker::Internet.unique.email, password: "password123")
    @category = Category.create!(name: "Интеграция")
  end
  test "GET /account/posts/new requires auth" do
    get new_account_post_path
    assert_response :redirect
  end
  test "POST /account/posts creates post and redirects" do
    sign_in @user
    attrs = { title: "Заголовок", body: "Текст поста", category_id: @category.id }
    assert_difference -> { Post.count }, +1 do
      post account_posts_path, params: { post: attrs }
    end
    assert_response :redirect
    post = Post.order(created_at: :desc).first
    assert { post.creator_id == @user.id }
    assert { post.category_id == @category.id }
  end
end
