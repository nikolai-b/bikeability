class AddBookingIdToBookingAsset < ActiveRecord::Migration
  def change
    add_column :booking_assets, :booking_id, :integer
  end
end
