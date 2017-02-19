require 'test_helper'

class PortaPorteseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get porta_portese_index_url
    assert_response :success
  end

end
