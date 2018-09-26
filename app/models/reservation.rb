class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  # validate check in date < check out date
  # validate no overlap booking

  validates :check_in, presence: true
  validates :check_out, presence: true

  validate :check_dates    #if customize validation, validate is wihtout (s)
  validate :reserved_date

  before_create :compute_total_price

  def check_dates
    #consider today date
    if self.check_in > self.check_out
      errors.add(:date_error, "Check in date must be before check out date")
    end
  end

  def reserved_date

    # search for all reservations of this listing
    existing_reserve = Reservation.where(listing_id: self.listing_id) # Res ?

    # I (reservation) have a start date and end date
    check_in = self.check_in
    check_out = self.check_out

    existing_reserve.each do |x| # Res 1

      all_reserved = x.check_in .. x.check_out  # => [29/9/2018, 30/9/2018] x.date must based on database column

      if (check_in.to_date .. check_out.to_date).overlaps?all_reserved
        self.errors.add(:Date, "This date is not available. Please select other date")
        break
      end

    end
  end

  #total price for stay
  def compute_total_price
    listing_price = Listing.find(self.listing_id).price

    self.total_price = (self.check_out - self.check_in) * listing_price
  end
end
