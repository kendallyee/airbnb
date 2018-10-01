class BraintreeController < ApplicationController

  #payment page
  def new
    #find reservation id  #in new.erb have to indicate id:@reservation
    @reservation = Reservation.find(params[:id])
    @client_token = Braintree::ClientToken.generate
  end

  #when check out,
  def checkout
    #find reservation id
    @reservation = Reservation.find(params[:id])
    #send the payment reuets to braintree
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    #send the total_price to braintree  for transaction
    result = Braintree::Transaction.sale(
     :amount => @reservation.total_price,
     :payment_method_nonce => nonce_from_the_client, #braintree generate token
     :options => {
        :submit_for_settlement => true
      }
     )

    if result.success?
      ReservationMailer.booking_email(@reservation).deliver_now #call mailer function from reservation_mailer.rb
      redirect_to root_path, :flash => { :success => "Transaction successful!" } #root = (homepage0 + flash msg
    else
      redirect_to root_path, :flash => { :error => "Transaction failed. Please try again." } #root= (homepage) + flash msg
    end
  end

end
