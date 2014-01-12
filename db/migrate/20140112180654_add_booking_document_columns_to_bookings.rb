class AddBookingDocumentToBookings < ActiveRecord::Migration
  def self.up
    add_attachment :bookings, :booking_document
  end

  def self.down
    remove_attachment :bookings, :booking_document
  end
end
