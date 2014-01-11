class AddUuidToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :uuid, :string
  end
end
