require 'test_helper'

class FlowControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get flow_index_url
    assert_response :success
  end

end
