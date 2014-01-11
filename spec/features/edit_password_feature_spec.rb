require 'capybara_helper'

feature "Edit admin password", type: :feature do
  scenario "success" do
    sign_in :admin

    click_on 'Edit password / email' 

    fill_in "Password", with: "password2"
    fill_in "Password confirmation", with: "password2"
    fill_in "Current password", with: "password"
    click_on "Update"

    page.should have_content "You updated your account successfully." 
  end

end



