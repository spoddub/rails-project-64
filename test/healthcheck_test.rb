# frozen_string_literal: true

require 'test_helper'

class HealthcheckTest < ActionDispatch::IntegrationTest
  test 'GET /up returns 200' do
    get '/up'
    assert_response :success
  end
end
