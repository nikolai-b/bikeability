require 'capybara_helper'

feature "Edit Instructor Email Template", type: :feature do
  scenario "success" do
    EmailTemplate.create!(template_name: "instructor", body: "test")

    sign_in :admin

    visit "/email_templates/instructor/edit"

    page.should have_content "<instructor_name>, <start_date>"

    fill_in "Body", with: 'Hi <instructor_name>, Dates <start_date>'

    click_on "Save"

    page.should have_content "Email template was successfully updated."

    create_new_booking "Amy Jones" , "amy@example.com", "Brett", "brett@example.com"

    open_email "amy@example.com"

    current_email.should have_content 'Hi Amy Jones,'

  end
end
