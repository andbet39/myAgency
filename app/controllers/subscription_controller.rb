class SubscriptionController < ApplicationController
  protect_from_forgery except: :webhook

  def new
  end
  def plans
    @stripe_list = Stripe::Plan.all
    @plans = @stripe_list[:data]
  end

  def subscription_checkout
       plan_id = params[:plan_id]
       plan = Stripe::Plan.retrieve(plan_id)

       customer  = Stripe::Customer.retrieve(current_user.stripe_customer_id)
       customer.source =  params[:stripeToken]
       customer.save

       stripe_subscription = customer.subscriptions.create(:plan => plan.id)
       logger.info(stripe_subscription.current_period_end)


       current_user.pro_end_date = Time.at(stripe_subscription.current_period_end).to_datetime
       current_user.is_pro=true
       current_user.save

       flash[:notice] = "Nuovo piano attivato correttamente"
       redirect_to edit_profile_path(current_user.profile.id)
     end



  def cancel_subscription
    customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    subscription_id=customer.subscriptions['data'][0].id
    sub = Stripe::Subscription.retrieve(subscription_id)
    sub.delete
    current_user.is_pro=false
    current_user.save
    flash[:notice] = "Piano disattivato correttamente"

    redirect_to edit_profile_path(current_user.profile.id)
  end


  def webhook
    event = Stripe::Event.retrieve(params["id"])

    case event.type
      when "invoice.payment_succeeded" #renew subscription
        stripe_customer_id  = event.data.customer
        user = User.where(:stripe_customer_id, stripe_customer_id).first
        user.pro_end_date = Time.at(event.data.object.period_end).to_datetime
        user.is_pro=true
        user.save!
      when "invoice.payment_failed"
        stripe_customer_id  = event.data.customer
        user = User.where(:stripe_customer_id, stripe_customer_id).first
        user.is_pro=false
        user.save!
    end
    render status: :ok, json: "success"
  end
end
