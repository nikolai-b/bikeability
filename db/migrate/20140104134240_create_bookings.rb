class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :school, index: true
      t.datetime :start_time
      t.integer :num_children
      t.integer :required_bikes
      t.integer :required_helmets

      t.timestamps
    end
  end
end
