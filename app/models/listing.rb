class Listing < ApplicationRecord
  belongs_to :user

  validates :country, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :user, presence: true

end
