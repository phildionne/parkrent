require 'spec_helper'

describe Rent do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:rent) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_rent) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should belong_to(:parking) }
    it { should have_many(:orders) }
  end

  # @note There is no presence validation spec for 'price' attribute because
  # of the way #monetize overrides the #price and #price= method. And there is
  # no validation of 'price' attribute numericality because #monetize default to 0
  # when passed an invalid value.
  describe :Validations do
    it { should validate_presence_of(:parking) }
    it { should validate_presence_of(:beginning) }
    it { should validate_presence_of(:termination) }
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end
end
