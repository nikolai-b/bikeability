require 'capybara_helper'

feature "Create a school teacher", type: :feature do
  scenario "successful creation" do
    sign_in :admin

    visit "/school_teachers/new"

    fill_in_new_teacher_form

    page.should have_content "School teacher was successfully created."
  end

  def fill_in_new_teacher_form
    fill_in "Name", with: "Joe Bloggs"
    fill_in "School", with: "School for the elderly"
    fill_in "Address line 1", with: "1 Worthington Crescent"
    fill_in "Address line 2", with: "Areasville"
    fill_in "City", with: "Leeds"
    fill_in "Postcode", with: "LS21 3QT"
    fill_in "Telephone number", with: "0113 245 3456"
    fill_in "Email", with: "teacher@example.com"

    click_on "Create School teacher"
  end


end



