require 'test_helper'

class MyInteractionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_interaction_index_url
    assert_response :success
  end

  test "should get new" do
    get my_interaction_new_url
    assert_response :success
  end

end
