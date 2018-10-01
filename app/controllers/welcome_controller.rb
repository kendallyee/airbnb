class WelcomeController < ApplicationController
  def index
    #get all listings information
    #render the view page
    # render "welcome/index"
    @listings = Listing.where(nil)
    @listings = @listings.country(params[:search][:country]) if params[:search] && params[:search][:country].present?
    @listings = @listings.property_type(params[:search][:property_type]) if params[:search] && params[:search][:property_type].present?
    @listings = @listings.page(params[:page]).per(10)
    render 'listings/index'
  end
end
