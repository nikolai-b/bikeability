class BookingInstructor < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :booking
end
