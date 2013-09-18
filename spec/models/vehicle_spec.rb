require 'spec_helper'

describe Vehicle do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:vehicle) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_vehicle) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should belong_to(:user) }
    it { should have_many(:orders).through(:user) }
  end

  describe :Validations do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:license_plate) }
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end
end
