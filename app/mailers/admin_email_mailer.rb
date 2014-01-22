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
    booking_assets = BookingAsset.where(:booking_id => booking.id)
    asset_urls = Array.new
    booking_assets.each do |asset|
      asset_urls.push(asset.booking_file.url)
    end
    asset_urls_joined = asset_urls.join(' ')
    school = School.find(booking.school_id)
    formatted_booking_date = booking.start_time.strftime("%A the #{booking.start_time.day.ordinalize} of %B, %Y")
    mail(to: school.email,
         subject: "Your Bikeability booking has been confirmed!",
         body: "#{asset_urls} - Your Bikeability booking starting on #{formatted_booking_date} for #{booking.num_children} children has been confirmed!  
         When you know the number of bikes please fill it in #{url}")
  end

  def instructor_email(booking, admin, instructor_id)
    @booking = booking
    @instructor = Instructor.find(instructor_id)
    @school = School.find(booking.school_id)
    @body = EmailTemplate.find_by(template_name: "instructor").body
    @body = replace_link
    @confirm_url = booking_url(booking) + '/instructors/' + instructor_id.to_s + '/edit'
    mail(to: @instructor.email,
         subject: "Bikeability at #{@school.school_name}")
  end

  private

  def replace_link url=nil 
    regex = /\<booking_link\:([^\>]*)\>/
    match = @body.match regex
    if match
      link_text = match[1].strip
      @body = @body.gsub(regex, "<a rel=\"booking_link\" href=\"#{url}\">#{link_text}</a>")
    end

    regex = /\<instructor_name\>/
    @body = @body.gsub(regex, @instructor.name)

    regex = /\<start_date\>/
    @body = @body.gsub(regex, @booking.start_time.to_date.to_s)
    
  end
end

