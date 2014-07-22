require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  test "should get match_data" do
    get :match_data
    assert_response :success
  end

  test "should get match_statistic" do
    get :match_statistic
    assert_response :success
  end

end
