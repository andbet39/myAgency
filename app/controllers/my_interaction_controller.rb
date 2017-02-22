class MyInteractionController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def new
    @listing = params['listing_id']
    @type = params['type']
  end

  def create

    listing = Listing.find(params['listing_id'])
    @interaction = Interaction.new
    @interaction.note = params['note']
    @interaction.name = params['name']
    @interaction.interest = params['interest']
    @interaction.vote = params['vote']
    @interaction.listing = listing
    @interaction.type = params['type']


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
