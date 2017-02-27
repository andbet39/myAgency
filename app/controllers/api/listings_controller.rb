class Api::ListingsController < ApplicationController
  before_action :authenticate_user!


  def getListingForSearch
    search  = Search.where(:id => params['search_id']).where(:user_id => current_user.id).first
    render json:search.listings
  end


  def togglefav
    listing = Listing.find(params['listing_id'])
    listing.favourite = !listing.favourite
    listing.save!

    render json:listing.favourite
  end
end
