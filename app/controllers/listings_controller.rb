class ListingsController < ApplicationController

  def index
    @listings = Listing.where(nil) # creates an anonymous scope # r!st un list all
    # 2nd run -filter if *params[:search] && - must put in params ,so can find the params country. (if you want to put search feature in index)
    @listings = @listings.country(params[:search][:country]) if params[:search] && params[:search][:country].present?
    #3rd run -filter
    @listings = @listings.property_type(params[:search][:property_type]) if params[:search] && params[:search][:property_type].present?
    #4th run - filtered list
    @listings = @listings.page(params[:page]).per(10)
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

    if @listing.save
      redirect_to root_path
    else
      flash[:error] = @listing.errors
      redirect_to new_listing_path
    end
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
      {images: []}
    )
  end
end
