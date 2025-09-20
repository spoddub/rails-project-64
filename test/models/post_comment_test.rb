require "test_helper"

class PostCommentTest < ActiveSupport::TestCase
  test "associations and validations" do
    user = User.create!(email: Faker::Internet.unique.email, password: "password123")
    category = Category.create!(name: Faker::Lorem.unique.word)
    post = Post.create!(title: "t", body: "b", category:, creator: user)
    root = PostComment.new(content: "root", user:, post:)
    assert { root.valid? }
    assert { root.save }
    child = PostComment.new(content: "child", user:, post:)
    child.parent = root
    assert { child.save }

    assert { child.parent == root }
    assert { root.children.count == 1 }
    assert { child.ancestry.start_with?("/") }
  end
end
