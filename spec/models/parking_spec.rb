require 'spec_helper'

describe Parking do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:parking) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_parking) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
  end

  describe :Validations do
    it { should validate_presence_of(:location) }
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end

end
