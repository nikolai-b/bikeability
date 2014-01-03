require 'capybara_helper'

feature "Create a booking email", type: :feature do
  scenario "edit booking email template" do
    sign_in :admin

    visit "/booking_email_template/edit"

    fill_in "Body", with: <<-EMAIL.gsub(/^\s/, "")
      Dear <name>,

      Nice email
    EMAIL

    click_on "Save"

    page.should have_content "Booking email template was successfully updated."

    school_teacher = SchoolTeacher.create name: "John"

    visit "school_teachers/#{school_teacher.id}/booking_emails/new"

    page.should have_content <<-EMAIL.gsub(/^\s/, "")
      Dear John,

      Nice email
    EMAIL


    ActionMailer::Base.deliveries.count.should == 0

    click_on "Send email"

    ActionMailer::Base.deliveries.count.should == 1
  end
end
