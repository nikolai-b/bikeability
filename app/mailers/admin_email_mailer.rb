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
    school = School.find(booking.school_id)
    formatted_booking_date = booking.start_time.strftime("%A the #{booking.start_time.day.ordinalize} of %B, %Y")
    mail(to: school.email,
         subject: "Your Bikeability booking has been confirmed!",
         body: "#{asset_urls} - Your Bikeability booking starting on #{formatted_booking_date} for #{booking.num_children} children has been confirmed!  
         When you know the number of bikes please fill it in #{url}")
  end

  def instructor_email(booking, admin, instructor_id)
    instructor = Instructor.find(instructor_id)
    school = School.find(booking.school_id)
    confirm_url = booking_url(booking) + '/instructors/' + instructor_id.to_s
    mail(to: instructor.email,
         subject: "Bikeability at #{school.school_name}",
         body:"Hi #{instructor.name}, Would you be available for Bikeability training at the following school please?
         Dates: #{booking.start_time},
         School: #{school.school_name}, #{school.postcode}
         Please confirm you avaliability #{confirm_url}") 
  end

end
