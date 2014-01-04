class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :school_teacher_id
      t.datetime :start_time
      t.integer :num_children
      t.integer :required_bikes
      t.integer :required_helmets

      t.timestamps
    end
  end
end
