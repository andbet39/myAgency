require 'test_helper'

class MyListingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_listing_index_url
    assert_response :success
  end

end
