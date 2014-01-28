require 'capybara_helper'
feature "Send reminder emails", type: feature do
  scenario "reminders" do
    sign_in :admin
    EmailTemplate.create_templates
    admin_school_warning = EmailTemplate.find_by(template_name: "admin_school_warning")
    admin_school_warning.update(body: "<school_name>")

    admin_instructor_warning = EmailTemplate.find_by(template_name: "admin_instructor_warning")
    admin_instructor_warning.update(body: "<instructor_name> <school_name>")


    school_future = School.create!(school_name: "Future School", teacher_name: "Ms Future", email: "future@example.com")
    school_soon_unready = School.create!(school_name: "Soon Unready School", teacher_name: "Mr Soon Unready", email: "soon.unready@example.com")
    school_soon_ready = School.create!(school_name: "Soon Ready School", teacher_name: "Ms Soon Ready", email: "soon.ready@example.com")
    school_very_soon_unready = School.create!(school_name: "Very Soon Unready School", teacher_name: "Mr Very Soon Unready", email: "very.soon.unready@example.com")

    instructor_bad = Instructor.create!(name: "Bad Instructor", email: "bad@example.com", telephone_number: "077..")
    instructor_good = Instructor.create!(name: "Good Instructor", email: "good@example.com", telephone_number: "077..")

    bookings = Array.new
    bookings << Booking.create!(school_id: school_future.id, start_time: 20.days.from_now, num_children: 20)
    bookings << Booking.create!(school_id: school_soon_ready.id, start_time: 10.days.from_now, num_children: 20, required_bikes: 10)
    bookings << Booking.create!(school_id: school_soon_unready.id, start_time: 10.days.from_now, num_children: 20)
    bookings << Booking.create!(school_id: school_very_soon_unready.id, start_time: 5.days.from_now, num_children: 20)
    add_instructor_to_bookings instructor_bad, bookings, nil
    add_instructor_to_bookings instructor_good, bookings, true

    clear_emails
    Booking.send_reminders
    sleep 0.1
    open_email "future@example.com"
    current_email.should_not have_content "Test"

    open_email "soon.unready@example.com"
    current_email.should have_content "Test"

    open_email "soon.ready@example.com"
    current_email.should_not have_content "Test"

    open_email "admin@example.com"
    current_email.should have_content "Very Soon Unready School"

    open_email "good@example.com"
    current_email.should_not have_content "Test"

    
    booking = Booking.find_by(school_id: school_future.id)
    BookingInstructor.where(booking_id: booking.id).find_by(instructor_id: instructor_bad.id).update(created_at: 3.days.ago)
    Booking.where(required_bikes: nil).update_all(required_bikes: 5)

    clear_emails
    Booking.send_reminders
    sleep 0.1

    open_email "admin@example.com"
    current_email.should have_content "Bad Instructor"
    current_email.should have_content "Future School"

  end

  def add_instructor_to_bookings instructor, bookings, available=nil
    bookings.each do |booking|
      BookingInstructor.create!(booking_id: booking.id, instructor_id: instructor.id, available: available)
    end
  end
end

