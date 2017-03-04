class MyInteractionController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
  end

  def new
    @interaction = Interaction.new
    @interaction.listing_id = params['listing_id']
    @listing = Listing.find(params['listing_id'])
    @inttype = params['inttype']

  end

  def create

    listing = Listing.find(params['listing_id'])
    @interaction = Interaction.new
    @interaction.user = current_user
    @interaction.note = params['note']
    @interaction.name = params['name']
    @interaction.interest = params['interest']
    @interaction.vote = params['vote']
    @interaction.listing = listing
    @interaction.inttype = params['inttype']


    respond_to do |format|
      if @interaction.save
        format.html { redirect_to listing, notice: 'Interaction was successfully created.' }
        format.json { render :show, status: :created, location: @interaction }
      else
        format.html { render :new }
        format.json { render json: @interaction.errors, status: :unprocessable_entity }
      end
    end

  end
end
