class MyListingController < ApplicationController
  before_action :authenticate_user!

  def index

    @min_prc = params['min_prc']
    @max_prc = params['max_prc']
    @min_mq = params['min_mq']
    @max_mq = params['max_mq']
    @zone_id = params['zone_id']
    
    if !current_user.ispro
      logger.info("Listing for non pro user")
      flash.now[:warning] = "Attiva il piano MyAgencyCall! Pro! per vedere più annunci!"

      @sr = SearchResult.limit(20).joins(:search).where('searches.user_id = ?', current_user.id).joins(:listing)
    else
      logger.info("Listing for pro user")
      @sr = SearchResult.joins(:search).where('searches.user_id = ?', current_user.id).joins(:listing)
    end
    if(@zone_id != nil && @zone_id != "" && @zone_id !='all')
      @sr = @sr.where('listings.  zone_id = ?',@zone_id)
    end
    if(@min_mq != nil && @min_mq != "")
      @sr = @sr.where('mt > ?',@min_mq)
    end
    if(@max_mq != nil && @max_mq != "")
      @sr = @sr.where('mt < ?',@max_mq)
    end
    if(@min_prc != nil && @min_prc != "")
      @sr = @sr.where('PRICE > ?',@min_prc)
    end
    if(@max_prc != nil && @max_prc != "")
      @sr = @sr.where('PRICE < ?',@max_prc)
    end

  end
end
