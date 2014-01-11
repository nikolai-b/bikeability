require 'spec_helper'

describe BookingEmailTemplate do
  describe ".singular_template" do
    before do
      BookingEmailTemplate.destroy_all
    end

    specify do
      booking = BookingEmailTemplate.singular_template

      booking.id.should_not be_nil

      next_booking = BookingEmailTemplate.singular_template

      next_booking.should == booking
    end
  end


  describe ".email_body_for" do
    specify do
      school = School.new teacher_name: "John"

      booking_email_template = BookingEmailTemplate.singular_template 
      booking_email_template.body = "Dear <name>, nice email"
      booking_email_template.save
      body = BookingEmailTemplate.email_body_for school
      body.should =~ /John/
    end
  end
end
