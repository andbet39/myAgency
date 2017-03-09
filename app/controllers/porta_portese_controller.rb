class PortaPorteseController < ApplicationController
    before_action :authenticate_user!


  def index

  end

  def run_search

    search   = Search.find(params['search_id'])
    logger.info(  search.last_run)
    logger.info( Time.now.utc - 2.hours)
    if search.last_run != nil && search.last_run > (Time.now.utc - 2.hours)

      flash.now[:notice] = "Non è possibile eseguire la stessa ricerca prima di due ore!"
    else
      service  = ListingService.new
      search.last_run = Time.now.utc
      search.save!
      if search.user.ispro
        service.parse_on_pp(params['search_id'])
      end
      service.parse_on_subito(params['search_id'])
    end

    redirect_back(fallback_location: searches_path)
  end



end
