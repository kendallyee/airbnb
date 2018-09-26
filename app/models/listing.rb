class Listing < ApplicationRecord
  belongs_to :user

  validates :country, :state, :city, :zipcode, :address, :user, presence: true
  validates :price, presence: true, numericality: {greater_than: 0}

  has_many :reservations

  mount_uploaders :images, ListingImagesUploader

end
