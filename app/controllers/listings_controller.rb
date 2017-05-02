class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.where(:user_id => current_user.id)
  end


  def view
    @has_help = true



    @search = Search.find(params['search_id'])
    @min_prc = params['min_prc']
    @max_prc = params['max_prc']
    @min_mq = params['min_mq']
    @max_mq = params['max_mq']


    @results = @search.search_results.joins(:listing)
    if(@min_mq != nil && @min_mq != "")
      @results = @results.where('mt > ?',@min_mq)
    end
    if(@max_mq != nil && @max_mq != "")
      @results = @results.where('mt < ?',@max_mq)
    end
    if(@min_prc != nil && @min_prc != "")
      @results = @results.where('PRICE > ?',@min_prc)
    end
    if(@max_prc != nil && @max_prc != "")
      @results = @results.where('PRICE < ?',@max_prc)
    end

    if !current_user.ispro
      logger.info("Listing for non pro user")
      @results = @results.limit(10)
    else
      logger.info("Listing for pro user")
      @results = @results
    end



    @newcount =  @search.search_results.where(:is_new => true).count
    @avg_pricemq = @search.search_results.joins(:listing).average('price/mt')
    @title = "Annunci per " + @search.keyword + " in zona "+ @search.zone.name




    NotificationService.clear_search_notification(@search.id)

  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:title, :link, :tel, :tel2, :email, :description, :insert_date, :mt, :zona, :id_annuncio, :origin, :price,:favourite)
    end
end
