class CreateBookingEmailTemplates < ActiveRecord::Migration
  def change
    create_table :booking_email_templates do |t|
      t.text :body

      t.timestamps
    end
  end
end
