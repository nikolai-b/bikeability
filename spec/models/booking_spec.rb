require 'spec_helper'

describe Booking do
  describe "#uuid" do
    specify do
      booking = Booking.create!(num_children: 10)
      uuid = booking.uuid

      booking.reload
      booking.uuid.should == uuid
   end
  end
end
