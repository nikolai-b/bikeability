class AddInstructorIdsToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :instructor1_id, :integer
    add_column :bookings, :instructor2_id, :integer
  end
end
