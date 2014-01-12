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
    school = School.find(booking.school_id)
    mail(to: school.email,
         subject: "Your Bikeability booking has been confirmed!",
         body: "Your Bikeability booking starting on the #{booking.start_time} for #{booking.num_children} has been confirmed!  
         When you know the number of bikes please fill it in #{url}")
  end

end
