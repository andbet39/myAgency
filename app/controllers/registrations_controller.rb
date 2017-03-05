  class RegistrationsController < Devise::RegistrationsController
  def create
    super # this calls Devise::RegistrationsController#create as usual
    # after creating a new user, create a profile that has
    # the profile.user_id field set to the user_id of the user jsut created
    if resource.save
        resource.create_profile
        customer = Stripe::Customer.create(
                :description => "Customer for " + resource.email ,
                :source => params[:stripeToken],
                :email => resource.email
              )
        current_user.stripe_customer_id = customer.id
        current_user.save
    end
  end

  def destroy
    super
    if resource.destroy
        @profile = Profile.find(user_id: resource.id)
        @profile.destroy
    end
  end
end
