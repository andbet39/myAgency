require 'test_helper'

class ServiceTestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get service_test_index_url
    assert_response :success
  end

end
