require 'spec_helper'

describe SchoolTeacher do
  describe "#uuid" do
    specify do
      school_teacher = SchoolTeacher.create!
      uuid = school_teacher.uuid

      school_teacher.reload
      school_teacher.uuid.should == uuid
      


   end
  end
end
