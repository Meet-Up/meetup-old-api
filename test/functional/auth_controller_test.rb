require 'test_helper'

class AuthControllerTest < ActionController::TestCase
  test "should get get_token" do
    get :get_token
    assert_response :success
  end

  test "should get confirm_user" do
    get :confirm_user
    assert_response :success
  end

end
