class AdminEmailMailer < ActionMailer::Base
  default from: 'admin@bikeability.herokuapp.com'

  def admin_email(booking, admin, new_or_updated)
    url = ''# school_teacher_booking_url booking.school_teacher, booking
    capitalize_new_or_updated = new_or_updated.capitalize
    mail(to: admin.email,
         subject: "#{capitalize_new_or_updated} Bikeability booking requested",
         body: "There is a #{new_or_updated} Bikeability booking requested by #{booking.school_teacher.school}. More info  #{url}")
  end

end
