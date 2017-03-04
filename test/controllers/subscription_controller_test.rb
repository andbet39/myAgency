require 'test_helper'

class SubscriptionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get subscription_new_url
    assert_response :success
  end

  test "should get subscription_checkout" do
    get subscription_subscription_checkout_url
    assert_response :success
  end

  test "should get webhook" do
    get subscription_webhook_url
    assert_response :success
  end

end
