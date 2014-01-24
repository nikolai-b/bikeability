class EmailMailer < ActionMailer::Base
  default from: 'admin@bikeability.herokuapp.com'

  def admin_email(booking, admin, new_or_updated)
    # TECHDEBT 
    url = edit_booking_url(booking)
    capitalize_new_or_updated = new_or_updated.capitalize
    mail(to: admin.email,
         subject: "#{capitalize_new_or_updated} Bikeability booking requested",
         body: "There is a #{new_or_updated} Bikeability booking requested by #{booking.school.school_name}. More info  #{url}")
  end

  def school_email(booking, admin, host)
    url = edit_booking_url(booking)
    booking_assets = BookingAsset.where(:booking_id => booking.id)
    asset_urls = Array.new
    booking_assets.each do |asset|
      attachments[asset.booking_file_file_name.to_s] = File.read(asset.booking_file.path) #open("http://#{host}#{asset.booking_file.url}").read 
    end
    @school = School.find(booking.school_id)
    @booking = booking
    body = EmailTemplate.find_by(template_name: "school").body
    body = replace_text body
    email = mail(to: @school.email,
         subject: "Your Bikeability booking has been confirmed!",
         body: body, content_type: "text/html")
    email.deliver
  end

  def instructor_email(booking, admin, instructor_id)
    @booking = booking
    @instructor = Instructor.find(instructor_id)
    @school = School.find(booking.school_id)
    body = EmailTemplate.find_by(template_name: "instructor").body
    @confirm_url = booking_url(booking) + '/instructors/' + instructor_id.to_s + '/edit'
    body = replace_text body
    email = mail(to: @instructor.email,
         subject: "Bikeability at #{@school.school_name}",
         body: body,
         content_type: "text/html" )
    email.deliver
  end

  def booking_email(school, admin, body)
    @school = school
    body = replace_text body
    email = mail(to: school.email,
         reply_to: admin.email,
         bcc: admin.email,
         subject: 'Bikeability booking',
         content_type: "text/html",
         body: body)
    email.deliver
  end

  private


  def replace_text body
    EmailTemplate.replace_text_holders.each do |text, replacement_string|
      regex = /\<#{text}\>/
      begin
        replacement = eval(replacement_string) 
      rescue
      
      else
        body = body.gsub(regex, replacement.to_s)
      end
    end
    body
  end

end
