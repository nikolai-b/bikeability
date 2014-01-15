class AddInstructorAvailableToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :instructor1_available, :boolean
    add_column :bookings, :instructor2_available, :boolean
  end
end
