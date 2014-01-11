require 'spec_helper'

describe School do
  describe "#uuid" do
    specify do
      school = School.create!
      uuid = school.uuid

      school.reload
      school.uuid.should == uuid
      


   end
  end
end
