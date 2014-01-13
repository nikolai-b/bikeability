class CreateBookingInstructors < ActiveRecord::Migration
  def change
    create_table :booking_instructors do |t|

      t.timestamps
    end
  end
end
