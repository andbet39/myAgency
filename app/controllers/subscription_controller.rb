class SubscriptionController < ApplicationController
  def new
  end

  def subscription_checkout
      plan_id = params[:plan_id]
       plan = Stripe::Plan.retrieve(plan_id)
       #This should be created on signup.
       customer = Stripe::Customer.create(
               :description => "Customer for" + current_user.email ,
               :source => params[:stripeToken],
               :email => current_user.email
             )
       # Save this in your DB and associate with the user;s email
       current_user.is_pro=true
       current_user.save

       flash[:notice] = "Successfully created a charge"
       redirect_to edit_profile_path(current_user.profile.id)
     end

  def webhook
  end

  def cancel_subscription
    current_user.is_pro=false
    current_user.save

    redirect_to edit_profile_path(current_user.profile.id)
  end
end
