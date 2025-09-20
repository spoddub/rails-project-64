require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "associations and validations" do
    user = User.create!(email: Faker::Internet.unique.email, password: "password")
    category = Category.create!(name: Faker::Book.unique.genre)

    post = Post.new(
      title: "Title",
      body:  "Body",
      category: category,
      creator: user
    )

    assert { post.valid? }
    assert { post.creator == user }
    assert { post.category == category }
  end
end
