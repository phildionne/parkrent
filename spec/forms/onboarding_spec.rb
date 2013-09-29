require 'spec_helper'

describe Onboarding do

  describe :Factories do
    context "Valid factory" do
      subject { build(:onboarding) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { build(:invalid_onboarding) }
      specify { should_not be_valid }
    end
  end
end
