class PortaPorteseController < ApplicationController
    before_action :authenticate_user!


  def index

  end

  def run_search

  service  = ListingService.new
    service.parse_on_pp(params['search_id'])
    service.parse_on_subito(params['search_id'])

    
    redirect_back(fallback_location: searches_path)
  end



end
