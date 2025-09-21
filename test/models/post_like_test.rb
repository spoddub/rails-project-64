# frozen_string_literal: true

require 'test_helper'

class PostLikeTest < ActiveSupport::TestCase
  test 'associations and uniqueness validation' do
    assert_equal :belongs_to, PostLike.reflect_on_association(:post).macro
    assert_equal :belongs_to, PostLike.reflect_on_association(:user).macro

    user     = User.create!(email: 'm@example.com', password: 'secret123')
    category = Category.create!(name: 'Cats')
    post     = Post.create!(title: 'T', body: 'B', category: category, creator: user)

    PostLike.create!(user:, post:)
    dup = PostLike.new(user:, post:)
    assert_not dup.valid?, 'duplicate like must be invalid'
  end
end
