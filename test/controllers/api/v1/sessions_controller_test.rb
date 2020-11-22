require 'test_helper'

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get auth_by_email_and_password" do
    get api_v1_sessions_auth_by_email_and_password_url
    assert_response :success
  end

  test "should get auth_by_token" do
    get api_v1_sessions_auth_by_token_url
    assert_response :success
  end

end
