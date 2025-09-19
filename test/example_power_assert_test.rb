require "test_helper"

class ExamplePowerAssertTest < ActionDispatch::IntegrationTest
  test "#update" do
    user = User.create!(email: Faker::Internet.email, password: "secret123")
    attrs = { resume_mail_enabled: false }
    patch account_newsletters_path(user), params: { user: attrs }
    assert_response :redirect

    user.reload
    assert { user.resume_mail_enabled == attrs[:resume_mail_enabled] }
  end
end
