class ServiceTestController < ApplicationController
  def index
    l = ListingService.new

    l.parse (params['search_id'])

  end
end
