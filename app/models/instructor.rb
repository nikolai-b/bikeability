class Instructor < ActiveRecord::Base
  has_many :booking_instructors
  has_many :bookings, through: :booking_instructors
end
