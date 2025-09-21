# frozen_string_literal: true

require 'test_helper'

module Account
  class PostsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user     = User.create!(email: 'a@example.com', password: 'secret123')
      @category = Category.create!(name: 'Misc')
    end

    test 'GET /account/posts/new requires auth' do
      get new_account_post_path
      assert_response :redirect
    end

    test 'POST /account/posts creates post and redirects' do
      sign_in @user
      assert_difference -> { Post.count }, +1 do
        post account_posts_path, params: { post: { title: 'T', body: 'B', category_id: @category.id } }
      end
      created = Post.order(:created_at).last
      assert_redirected_to post_path(created)
    end
  end
end
