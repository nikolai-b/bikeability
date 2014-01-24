require 'capybara_helper'

feature "Create a booking email", type: :feature do
  scenario "booking email template" do
    sign_in :admin

    edit_booking_email_template
    page.should have_content "Email template was successfully updated."

    school  = create_default_school "school@example.com"
    send_booking_email school

    open_email "school@example.com"
    current_email.should have_content "Dear Ms Teacher"
    school.destroy
  end
  
  scenario "only can be viewed unauthrised" do
    sign_in :admin
    EmailTemplate.create_templates
    school = create_default_school "default.school@example.com"
    instructor1 = create_new_instructor "Amy Jones", "amy@example.com"
    instructor2 = create_new_instructor "Bad Chris", "chris@example.com"
    booking = create_new_booking school, instructor1, instructor2
    sign_out

    pages_to_visit = [email_templates_path, instructors_path, new_instructor_path,
                      edit_instructor_path(instructor1), instructor_path(instructor1), 
                      new_school_booking_path(school), schools_path(school), new_school_path, edit_school_path(school), school_path(school),
                      bookings_path]
    pages_to_visit.each do |page_to_visit|
      visit page_to_visit
      page.should have_content "You need to sign in or sign up before continuing"
      sign_in :admin
      page.should_not have_content "You need to sign in or sign up before continuing"
      sign_out
    end

    pages_to_visit = [booking_path(booking), edit_booking_path(booking), "/bookings/#{booking.uuid}/instructors/#{instructor1.id}/edit"]
    pages_to_visit.each do |page_to_visit|
      visit page_to_visit
      page.should_not have_content "You need to sign in or sign up before continuing"
    end
  end

  scenario "create a booking" do
    sign_in :admin
    school = create_default_school "teacher.book@example.com"
    edit_instructor_email_template
    instructor1 = create_new_instructor "Chris Martin" , "chris.martin@example.com"
    instructor2 = create_new_instructor "Brett", "brett@example.com"
    email_template_school = EmailTemplate.find_by(template_name: "school")
    email_template_school.update(body: "Your Bikeability booking starting on <formatted_date> for <number_of_children> Please update <a href=\"<booking_url>\">booking</a>")
    booking = create_new_booking school, instructor1, instructor2
    page.should have_content "Booking created. Email sent to teacher. Emails sent to Chris Martin and Brett"
    sign_out

    open_email "teacher.book@example.com"
    current_email.should have_content 'Your Bikeability booking starting on Tuesday the 13th of January, 2015 for 17'
    current_email.find_link('booking').click
    page.should have_content "Default School"

    find_field('Number of children').value.should eq '17'
    find_field('Required number of bikes').value.should eq '13'
    page.should_not have_content "Chris Martin"

    sign_in :admin
    open_email "chris.martin@example.com"

    current_email.should have_content 'Hi Chris Martin'

    sign_out
    current_email.find_link('a').click
    page.should have_content "Are you available"

    sign_in :admin
    visit "/bookings"
    click_on "Default School"
    page.should have_content "Chris Martin"
    page.should have_content "Brett"
  end

  def create_new_booking school, instructor1, instructor2
    visit "/schools"
    click_on "Create booking"

    page.should have_content school.teacher_name
    page.should have_content school.school_name

    fill_in "Start date", with: "13/01/2015"
    fill_in "Number of children", with: 17
    fill_in "Required number of bikes", with: 13
    fill_in "Required number of helmets", with: 17
    select(instructor1.name, :from => "Instructor1")
    select(instructor2.name, :from => "Instructor2")

    click_on "Create booking"
    Booking.find_by(school_id: school.id)
  end

  def edit_booking_email_template
    visit "/email_templates/booking/edit"

    fill_in "Body", with: <<-EMAIL.gsub(/^\s/, "")
      Dear <teacher_name>,

      Nice email
    EMAIL

    click_on "Save"
  end

  def send_booking_email school
    visit schools_path
    clear_emails
    click_on "Send booking email"
  end

  def edit_instructor_email_template
    visit "/email_templates/instructor/edit"

    page.should have_content "<teacher_name> <instructor_name> <school_name>"
    fill_in "Body", with: 'Hi <instructor_name>, Dates <start_date> are you <a href="<instructor_confirm_url>">available</a>?'
    click_on "Save"

    page.should have_content "Email template was successfully updated."
  end

end
