class Api::ListingsController < ApplicationController
  before_action :authenticate_user!


  def getListingForSearch
    search  = Search.where(:id => params['search_id']).where(:user_id => current_user.id).first
    @listings = search.listings.order('tel DESC')
    render :template => 'listings/index.json'
  end


  def togglefav
    @listing = Listing.find(params['listing_id'])
    @listing.favourite = !@listing.favourite
    @listing.save!

    render :template => 'listings/show.json'
  end
end
