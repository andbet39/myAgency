#if Rails.env == 'production'
#  Rails.configuration.stripe = {
#    :publishable_key => MY_PUBLISHABLE_KEY,
#    :secret_key      => MY_SECRET_KEY
#else
  Rails.configuration.stripe = {
    :publishable_key => 'pk_test_p0QQDCeJQA7W9X9y0VP7QOz5' ,
    :secret_key      => 'sk_test_vkLyPOI6CcWC2xtrSa2r90up'
  }
#end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
