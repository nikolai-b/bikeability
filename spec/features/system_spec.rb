require 'capybara_helper'

feature "Create a booking email", type: :feature do
  scenario "edit booking email template" do
    sign_in :admin

    create_email_template
    page.should have_content "Booking email template was successfully updated."

   # send_new_email "teacher@example.com"
    create_new_instructor "Chris Martin" , "chris.martin@example.com"
    create_new_instructor "Brett", "brett@example.com"


    create_new_booking
    page.should have_content "Booking created. Email sent to teacher."

    open_email "teacher.book@example.com"

    current_email.should have_content 'Your Bikeability booking starting on Tuesday the 13th of January, 2015 for 17'

    current_email.find_link('a').click
    page.should have_content "Booking School"
    find_field('Number of children').value.should eq '17'
    find_field('Required number of bikes').value.should eq '13'
  end

  def create_email_template
    visit "/booking_email_template/edit"

    fill_in "Body", with: <<-EMAIL.gsub(/^\s/, "")
      Dear <name>,

      <booking_link: Book here>

      Nice email
    EMAIL

    click_on "Save"
  end

  def send_new_email email
    send_new_email "teacher@example.com"
    school = School.create school_name: "Leeds Low", email: email, teacher_name: "John Barnaby-Gumbleton-Smythe"

    visit new_school_booking_email_path school

    page.should have_content <<-EMAIL.gsub(/^\s/, "")
      Dear John Barnaby-Gumbleton-Smythe,

      <booking_link: Book here>

      Nice email
    EMAIL


    clear_emails
    click_on "Send email"
  end

  def create_new_instructor name, email
    visit "/instructors"
    click_on "New Instructor"
    
    fill_in "Name", with: name
    fill_in "Email", with: email
    fill_in "Telephone number", with: "0779"

    click_on "Save"
  end

  def create_new_booking
#    open_email "teacher@example.com"
    school = School.create school_name: "Booking School", email: "teacher.book@example.com", teacher_name: "Mr Booking"
    visit "/schools"
    click_on "Create booking"
#    current_email.should have_content 'Nice email'
#    current_email.find_link('a').click

    page.should have_content "Mr Booking"
    page.should have_content "Booking School"

    fill_in "Start date", with: "13/01/2015"
    fill_in "Number of children", with: 17
    fill_in "Required number of bikes", with: 13
    fill_in "Required number of helmets", with: 17
    select("Chris Martin", :from => "Instructor1")
    select("Brett", :from => "Instructor2")

    click_on "Create booking"
  end
end
