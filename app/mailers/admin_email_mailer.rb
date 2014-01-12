class AdminEmailMailer < ActionMailer::Base
  default from: 'admin@bikeability.herokuapp.com'

  def admin_email(booking, admin, new_or_updated)
    # TECHDEBT 
    url = edit_booking_url(booking)
    capitalize_new_or_updated = new_or_updated.capitalize
    mail(to: admin.email,
         subject: "#{capitalize_new_or_updated} Bikeability booking requested",
         body: "There is a #{new_or_updated} Bikeability booking requested by #{booking.school.school_name}. More info  #{url}")
  end

  def school_email(booking, admin, new_or_updated)
    url = edit_booking_url(booking)
    url2 = booking.booking_document.url
    booking_minus_one = Booking.find_by(:id => booking.id-1)
    booking_minus_two = Booking.find_by(:id => booking.id-2)
    url3 = booking_minus_one.booking_document.url
    url4 = booking_minus_two.booking_document.url
    school = School.find(booking.school_id)
    formatted_booking_date = booking.start_time.strftime("%A the #{booking.start_time.day.ordinalize} of %B, %Y")
    mail(to: school.email,
         subject: "Your Bikeability booking has been confirmed!",
         body: "#{url2} - #{url3} - #{url4} - Your Bikeability booking starting on #{formatted_booking_date} for #{booking.num_children} children has been confirmed!  
         When you know the number of bikes please fill it in #{url}")
  end

end
