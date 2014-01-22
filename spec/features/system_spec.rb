require 'capybara_helper'

feature "Create a booking email", type: :feature do
  before do
    EmailTemplate.create!(template_name: "instructor", body: "test")
  end

  scenario "edit booking email template" do
    sign_in :admin

    create_email_template
    page.should have_content "Booking email template was successfully updated."

   # send_new_email "teacher@example.com"

    create_new_booking("Chris Martin" , "chris.martin@example.com", "Brett", "brett@example.com")
       
    page.should have_content "Booking created. Email sent to teacher. Emails sent to Chris Martin and Brett"

    open_email "teacher.book@example.com"

    current_email.should have_content 'Your Bikeability booking starting on Tuesday the 13th of January, 2015 for 17'

    sign_out

    current_email.find_link('a').click
    
    page.should have_content "Booking School"
    find_field('Number of children').value.should eq '17'
    find_field('Required number of bikes').value.should eq '13'
    page.should_not have_content "Chris Martin"
    
    visit "/bookings"
    
    page.should have_content "You need to sign in or sign up before continuing"
   
    sign_in :admin
    open_email "chris.martin@example.com"

    current_email.should have_content 'Hi Chris Martin'
    
    sign_out

    current_email.find_link('a').click

    page.should have_content "Are you available"
    sign_in :admin
    
    visit "/bookings"
    
    click_on "Booking School"
    page.should have_content "Chris Martin"
    page.should have_content "Brett"


  end



  def create_email_template
    visit "/booking_email_template/edit"

    fill_in "Body", with: <<-EMAIL.gsub(/^\s/, "")
      Dear <instructor_name>,

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

end
