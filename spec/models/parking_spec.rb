require 'spec_helper'

describe Parking do

  describe :Factories do
    context "Valid factory" do
      subject { create(:parking) }
      specify { should be_valid }
    end

    context "Valid factory" do
      subject { create(:parking_with_rents) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { build(:invalid_parking) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should belong_to(:user) }
    it { should have_many(:rents).dependent(:destroy) }
    it { should have_many(:clients).through(:rents) }
  end

  describe :Validations do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:location) }
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end
end
