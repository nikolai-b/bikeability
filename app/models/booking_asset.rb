class BookingAsset < ActiveRecord::Base
  belongs_to :booking

  has_attached_file :booking_file
end
