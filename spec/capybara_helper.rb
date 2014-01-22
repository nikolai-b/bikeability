# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] = 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'capybara/email/rspec'
require 'fabricator'

Dir[(File.expand_path "../support/", __FILE__) + "/**/*.rb"].each {|f| require f}

Capybara.register_driver :webkit do |app|
  Capybara::Webkit::Driver.new app
end

Capybara.javascript_driver = :webkit

module UserSigninSteps
  def sign_in type, email=nil, password="password"
    user = if email.nil?
             User.create email: "admin@example.com", password: password
           else
             User.find_by email: email
           end

    visit "/"
    fill_in "Email", with: user.email
    fill_in "Password", with: password
    click_on "Sign in"

    user
  end

  def sign_out
    click_on "Logout"
  end

  def create_new_booking instructor1_name, instructor1_email, instructor2_name, instructor2_email
    school = School.create school_name: "Booking School", email: "teacher.book@example.com", teacher_name: "Mr Booking"
    create_new_instructor instructor1_name, instructor1_email
    create_new_instructor instructor2_name, instructor2_email

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
    select(instructor1_name, :from => "Instructor1")
    select(instructor2_name, :from => "Instructor2")

    click_on "Create booking"
  end
  
  def create_default_school
    School.create!(school_name: "Default School", teacher_name: "Ms Teacher", email: "school@example.com")
  end
  
  def create_new_instructor name, email
    visit "/instructors"
    click_on "New Instructor"

    fill_in "Name", with: name
    fill_in "Email", with: email
    fill_in "Telephone number", with: "0779"

    click_on "Save"
  end

end



RSpec.configure do |config|

  config.after do
    if !$saved_and_opened_page &&
        (example.metadata[:type] == :feature) &&
        example.exception.present?
      save_and_open_page
      $saved_and_opened_page = true
    end

  end

  config.include Capybara::DSL #https://github.com/rspec/rspec-rails/issues/360
  config.include UserSigninSteps

  config.use_transactional_examples = true
  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"
end

