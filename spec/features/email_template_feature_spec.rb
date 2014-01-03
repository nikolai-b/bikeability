require 'capybara_helper'

feature "Create a booking email template", type: :feature do
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
  end
end
