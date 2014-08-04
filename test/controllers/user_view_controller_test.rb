require 'test_helper'

class UserViewControllerTest < ActionController::TestCase
  test "should get view" do
    get :view
    assert_response :success
  end

  test "should get filter" do
    get :filter
    assert_response :success
  end

end
