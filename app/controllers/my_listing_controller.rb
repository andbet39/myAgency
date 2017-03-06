class MyListingController < ApplicationController
  before_action :authenticate_user!

  def index

    if !current_user.ispro
      logger.info("Listing for non pro user")
      flash.now[:warning] = "Attiva il piano MyAgencyCall! Pro! per vedere più annunci!"

      @sr = SearchResult.limit(20).joins(:search).where('user_id = ?', current_user.id)
    else
      logger.info("Listing for pro user")
      @sr = SearchResult.joins(:search).where('user_id = ?', current_user.id)
    end
  end
end
