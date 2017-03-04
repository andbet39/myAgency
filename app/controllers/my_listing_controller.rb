class MyListingController < ApplicationController
  before_action :authenticate_user!

  def index
    @sr = SearchResult.joins(:search).where('user_id = ?', current_user.id)

  end
end
