require 'spec_helper'

describe User do

  describe :Factories do
    context "Valid factory" do
      subject { create(:user) }
      specify { should be_valid }

      subject { create(:user_with_vehicles) }
      specify { should be_valid }

      subject { create(:user_with_parkings) }
      specify { should be_valid }

      subject { create(:user_with_parkings_and_rents) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { build(:invalid_user) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:parkings).dependent(:destroy) }
    it { should have_many(:vehicles).dependent(:destroy) }
  end

  describe :Validations do
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end
end
