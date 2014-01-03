# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] = 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
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

