class CreateBookingInstructors < ActiveRecord::Migration
  def change
    create_table :booking_instructors do |t|
      t.integer :booking_id
      t.integer :school_id
      t.timestamps
    end
    add_index :booking_instructors, :booking_id
    add_index :booking_instructors, :school_id
  end
end
