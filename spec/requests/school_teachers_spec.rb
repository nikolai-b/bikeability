require 'spec_helper'

describe "SchoolTeachers" do
  describe "GET /school_teachers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get school_teachers_path
      response.status.should be(200)
    end
  end
end
