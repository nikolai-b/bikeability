class BookingEmailMailer < ActionMailer::Base
  default from: 'admin@bikeability.herokuapp.com'

  def booking_email(school_teacher, admin, body)
    mail(to: school_teacher.email,
         reply_to: admin.email,
         bcc: admin.email,
         subject: 'Bikeability booking',
         body: body)
  end
end
