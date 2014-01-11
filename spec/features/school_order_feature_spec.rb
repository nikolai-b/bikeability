require 'capybara_helper'

feature "Order schools index", type: :feature do
  scenario "success" do
    sign_in :admin

    school = School.create school_name: "Zulu School", teacher_name: "Andy"
    school = School.create school_name: "Aardvark School", teacher_name: "Mike"
    school = School.create school_name: "Middel School", teacher_name: "Zak"
    visit "/schools"

    click_on "School Name"
    uri = URI.parse(current_url)
    uri.should have_content "school_name"
    uri.should have_content "asc"

    click_on "School Name"
    uri = URI.parse(current_url)
    uri.should have_content "desc"
    
    click_on "School Name"
    uri = URI.parse(current_url)
    uri.should have_content "asc"
  end

  def get_url

  end
end



