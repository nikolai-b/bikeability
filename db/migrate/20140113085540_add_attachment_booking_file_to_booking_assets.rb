class AddAttachmentBookingFileToBookingAssets < ActiveRecord::Migration
  def self.up
    change_table :booking_assets do |t|
      t.attachment :booking_file
    end
  end

  def self.down
    drop_attached_file :booking_assets, :booking_file
  end
end
