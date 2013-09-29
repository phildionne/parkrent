require 'spec_helper'

describe GuestOrder do

  describe :Factories do
    context "Valid factory" do
      subject { build(:guest_order) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { build(:invalid_guest_order) }
      specify { should_not be_valid }
    end
  end
end
