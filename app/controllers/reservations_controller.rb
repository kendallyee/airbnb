class ReservationsController < ApplicationController

#show reservation page
  def show
    #appoint reservation with find by id
      @reservation = Reservation.find(params[:id])
  end

#create new reservation
  def create
  #find listing id
  @listing = Listing.find(params[:listing_id])
  @reservation = @listing.reservations.create(reservation_params)
  #current_user is from clearance helper
  @reservation.user_id = current_user.id

  if @reservation.save
    #refer to router. (listing.id, reservation.id) listing & reservation are nested
    redirect_to listing_reservation_path(@reservation.listing.id, @reservation)
  else

    redirect_to listing_path(@listing)

  end
end

#delete reservation
def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    redirect_to listing_path
end

#strong params
  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :listing_id, :check_in, :check_out, :total_price)
  end



end
