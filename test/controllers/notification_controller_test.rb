require 'test_helper'

class NotificationControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get notification_view_url
    assert_response :success
  end

end
