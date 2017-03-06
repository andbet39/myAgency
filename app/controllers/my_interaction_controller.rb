class MyInteractionController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
  end

  def new
    @interaction = Interaction.new
    @interaction.listing_id = params['listing_id']
    @listing = Listing.find(params['listing_id'])
    @interaction.inttype = params['inttype']

  end

  def create

    logger.info(params['listing_id'])
    @interaction = Interaction.new(interaction_params)
    @interaction.user = current_user

    respond_to do |format|
      if @interaction.save
        format.html { redirect_to @interaction.listing, success: 'Interaction was successfully created.' }
        format.json { render :show, status: :created, location: @interaction }
      else
        format.html { render :new }
        format.json { render json: @interaction.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interaction
      @interaction = Interaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interaction_params
      params.require(:interaction).permit(:name,:type, :vote, :interest, :note, :listing_id, :user_id,:inttype)
    end
end
