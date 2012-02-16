require_relative '../test_helper'

class HomeControllerTest < ActionController::TestCase
  setup :activate_authlogic
  test "should get index" do
    get :index
    assert_response :success
  end

end
