class BookingEmailMailer < ActionMailer::Base
  default from: 'admin@bikeability.herokuapp.com'

  def booking_email(school, admin, body)
    url = new_school_booking_url school
    body = replace_link body, url

    mail(to: school.email,
         reply_to: admin.email,
         bcc: admin.email,
         subject: 'Bikeability booking',
         body: body)
  end

  private

  def replace_link body, url
    regex = /\<booking_link\:([^\>]*)\>/
    body.gsub(regex, url)

    #Do something like this for HTML emails:
    #match = body.match regex
    #link_text = match[1].strip
    #body.gsub(regex, "<a rel=\"booking_link\" href=\"#{url}\">#{link_text}</a>")
  end
end
