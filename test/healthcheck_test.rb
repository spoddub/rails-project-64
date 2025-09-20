# frozen_string_literal: true

require "test_helper"

class HealthcheckTest < ActionDispatch::IntegrationTest
  test "GET /up returns 200" do
    get "/up"
    assert_response :success
    assert { response.status == 200 }
  end

  test "faker generates an email-looking string" do
    email = Faker::Internet.email
    assert { email.match?(/\A.+@.+\..+\z/) }
  end
end
