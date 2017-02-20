class Api::ListingsController < ApplicationController


  def getListingForSearch
    search  = Search.find(params['search_id'])
    render json:search.listings
  end


  def togglefav
    listing = Listing.find(params['listing_id'])
    listing.favourite = !listing.favourite
    listing.save!

    render json:listing.favourite
  end
end
