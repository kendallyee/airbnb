class ListingsController < ApplicationController

  def index
    @listings = Listing.page(params[:page]).per(10)
    render 'listings/index'
  end

  def show
    @listing = Listing.find(params[:id])
    render 'listings/show'
  end

  def edit
    @listing = Listing.find(params[:id])
    render 'listings/edit'
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
    redirect_to edit_listing_path(@listing)

  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

    redirect_to listings_path

  end

  #strong params
  private
  def listing_params
    params.require(:listing).
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
