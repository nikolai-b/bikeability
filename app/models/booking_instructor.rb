class BookingInstructor < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :booking
  accepts_nested_attributes_for :instructor
end
