require 'test_helper'

class ParsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get pars_create_url
    assert_response :success
  end

end
