require 'capybara_helper'

feature "Create a school", type: :feature do
  scenario "success" do
    sign_in :admin

    visit "/schools/new"

    fill_in_new_school_form

    page.should have_content "School was successfully created."
  end

  def fill_in_new_school_form
    fill_in "School name", with: "School for the elderly"
    fill_in "Address line 1", with: "1 Worthington Crescent"
    fill_in "Address line 2", with: "Areasville"
    fill_in "City", with: "Leeds"
    fill_in "Postcode", with: "LS21 3QT"
    fill_in "Telephone number", with: "0113 245 3456"
    fill_in "Email", with: "teacher@example.com"
    fill_in "Teacher name", with: "Joe Bloggs"

    click_on "Create School"
  end


end



