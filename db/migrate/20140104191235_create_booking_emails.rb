class CreateBookingEmails < ActiveRecord::Migration
  def change
    create_table :booking_emails do |t|
      t.string :body
    end
  end
end
