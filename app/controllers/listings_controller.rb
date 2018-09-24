class ListingsController < ApplicationController

  def index
    @listings = Listing.all
    render 'listings/index'
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def create
    @listing = Listing.new(listing_params)

    @listing.user_id = current_user.id

    @listing.save
      redirect_to root_path
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update(listing_params)

    flash[:success] = "Successfully edited listings!"
    redirect_to listings_path

  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

    redirect_to listings_path

  end

  #strong params
  private
  def listing_params
    params.require(:listings).
    permit(
      :name,
      :place_type,
      :property_type,
      :room_number,
      :bed_number,
      :guest_number,
      :country,
      :state,
      :city,
      :zipcode,
      :address,
      :price,
      :description,
      :user_id,
    )
  end
end
