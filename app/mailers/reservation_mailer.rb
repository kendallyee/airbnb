class ReservationMailer < ApplicationMailer
  default from: "leeyondae@gmail.com"

  #booking email (reservation) as per my reservation modelname.
  def booking_email(reservation) #customer, host, reservtion_id
    @user = reservation.user  #appoint reservation user id(email,name)
    @host = reservation.listing.user #appoint listing user(email,name)
    @listing = reservation.listing #appoint reservation. listing(which id)

    mail(to: @user.email, subject: "Thank you for your booking.") #after all info appointed, send an email to user(customer)
   end
end
