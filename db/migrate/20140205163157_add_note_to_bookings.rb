class AddNoteToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :note, :text
  end
end
