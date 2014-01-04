class BookingEmailMailer < ActionMailer::Base
  default from: 'admin@bikeability.herokuapp.com'

  def booking_email(school_teacher, admin, body)
    url = new_school_teacher_booking_url school_teacher
    body = replace_link body, url

    mail(to: school_teacher.email,
         reply_to: admin.email,
         bcc: admin.email,
         subject: 'Bikeability booking',
         body: body)
  end

  private

  def replace_link body, url
    regex = /\<booking_link\:([^\>]*)\>/

    match = body.match regex

    link_text = match[1].strip

    body.gsub(regex, "<a href='#{url}'>#{link_text}</a>")
  end
end
