class EmailMailer < ActionMailer::Base
  default from: 'admin@bikeability.herokuapp.com'

  def admin_email(booking, admin, new_or_updated)
    url = edit_booking_url(booking)
    capitalize_new_or_updated = new_or_updated.capitalize
    mail(to: admin.email,
         subject: "#{capitalize_new_or_updated} Bikeability booking requested",
         body: "There is a #{new_or_updated} Bikeability booking requested by #{booking.school.school_name}. More info  #{url}")
  end

  def school_email(booking, admin, host)
    attachments_array = Array.new
    booking.booking_assets.each do |asset|
      attachments[asset.booking_file_file_name.to_s] = open(asset.booking_file.url).read 
    end
    @school = booking.school
    @booking = booking
    send_email(@school.email, admin, "Your Bikeability booking has been confirmed!", 'school', attachments)
  end

  def instructor_email(booking, admin)
    @booking = booking
    @school = booking.school
    booking_instructors = @booking.booking_instructors.where(available: nil)
    booking_instructors.each do |booking_instructor|
      @instructor = booking_instructor.instructor
      @confirm_url = booking_url(booking) + '/instructors/' + @instructor.id.to_s + '/edit'
      send_email(@instructor.email, admin, "Bikeability at #{@school.school_name}", 'instructor')
    end
  end

  def booking_email(school, admin, body)
    @school = school
    send_email(school.email, admin, 'Bikeability booking', 'booking')
  end

  def admin_school_warning(booking, admin)
    @booking = booking
    @school = booking.school
    send_email(admin.email, admin, "#{@school.school_name} has not replied", 'admin_school_warning')
  end

  def admin_instructor_warning(booking_instructor, admin)
    @booking = booking_instructor.booking
    @instructor = booking_instructor.instructor
    @school = @booking.school
    send_email(admin.email, admin, "#{@instructor.name} has not confirmed availablity at #{@school.school_name}", 'admin_instructor_warning')
  end

  private
  
  def send_email(to_email, admin, subject, template_name, attachments=nil)
    email_template = EmailTemplate.find_by(template_name: template_name)
    body = replace_text email_template.body
    email = if to_email == admin.email
              mail(to: to_email,
                   subject: subject,
                   body: body,
                   content_type: 'text/html')
            else
              mail(to: to_email,
                   reply_to: admin.email,
                   bcc: admin.email,
                   subject: subject,
                   body: body,
                   content_type: "text/html")
            end
    email.deliver
  end


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
