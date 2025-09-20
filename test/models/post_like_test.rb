require "test_helper"

class PostLikeTest < ActiveSupport::TestCase
  test "associations and validations" do
    assert PostLike.reflect_on_association(:user).present?
    assert PostLike.reflect_on_association(:post).present?

    user = User.create!(email: Faker::Internet.email, password: "password")
    category = Category.create!(name: SecureRandom.hex(4))
    post = Post.create!(title: "T", body: "B", category: category, creator: user)

    like1 = PostLike.create!(user: user, post: post)
    assert like1.persisted?

    like2 = PostLike.new(user: user, post: post)
    refute like2.valid?
    assert_includes like2.errors[:user_id], "has already been taken"
  end
end
