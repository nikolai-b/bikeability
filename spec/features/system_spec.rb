require 'capybara_helper'

feature "Create a booking email", type: :feature do
  before(:all) do
    destroy_email_templates
    create_email_templates
  end
  after(:all) do
    destroy_email_templates
  end

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

  end

  scenario "create a booking" do
    sign_in :admin
    school = create_default_school "teacher.book@example.com"
    edit_instructor_email_template
    create_new_booking school, "Chris Martin" , "chris.martin@example.com", "Brett", "brett@example.com"
    page.should have_content "Booking created. Email sent to teacher. Emails sent to Chris Martin and Brett"

    open_email "teacher.book@example.com"
    current_email.should have_content 'Your Bikeability booking starting on Tuesday the 13th of January, 2015 for 17'

    sign_out

    current_email.find_link('a').click
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

  def create_new_booking school, instructor1_name, instructor1_email, instructor2_name, instructor2_email
    create_new_instructor instructor1_name, instructor1_email
    create_new_instructor instructor2_name, instructor2_email

    visit "/schools"
    click_on "Create booking"

    page.should have_content school.teacher_name
    page.should have_content school.school_name

    fill_in "Start date", with: "13/01/2015"
    fill_in "Number of children", with: 17
    fill_in "Required number of bikes", with: 13
    fill_in "Required number of helmets", with: 17
    select(instructor1_name, :from => "Instructor1")
    select(instructor2_name, :from => "Instructor2")

    click_on "Create booking"
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
