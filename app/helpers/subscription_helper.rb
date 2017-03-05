module SubscriptionHelper

  def self.getplans

    stripe_list = Stripe::Plan.all
    return  stripe_list[:data]
  end
end
