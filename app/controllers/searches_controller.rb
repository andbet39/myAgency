class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /searches
  # GET /searches.json
  def index
    @has_help = true
    @page_title = "Lista Ricerche"
    @searches = Search.where(:user_id => current_user.id )
    if !current_user.ispro
      flash.now[:warning] = "Attiva il piano MyAgencyCall! Pro! per creare altre ricerche!"
    end
  end
  # GET /searches/1
  # GET /searches/1.json
  def show
  end

  # GET /searches/new
  def new
    if !current_user.ispro
      c  = Search.where(:user_id => current_user.id).count
      if c > 1
        flash.now[:warning] = "Attiva il piano MyAgencyCall! Pro! per creare altre ricerche!"
        redirect_to edit_profile_path(current_user.profile.id)
      end
    end
      @search = Search.new

  end

  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(search_params)
    @search.user = current_user
    respond_to do |format|
      if @search.save
        format.html { redirect_to searches_path, notice: 'Search was successfully created.' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :new }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:keyword, :zona, :last_run,:zone_id)
    end
end
