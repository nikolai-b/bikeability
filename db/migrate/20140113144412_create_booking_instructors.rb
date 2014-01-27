class CreateBookingInstructors < ActiveRecord::Migration
  def change
    create_table :booking_instructors do |t|
      t.belongs_to :booking, index: true
      t.belongs_to :instructor, index: true
      t.boolean :available
      t.timestamps
    end
  end
end
