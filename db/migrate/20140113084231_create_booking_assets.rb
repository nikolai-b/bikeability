class CreateBookingAssets < ActiveRecord::Migration
  def change
    create_table :booking_assets do |t|

      t.timestamps
    end
  end
end
