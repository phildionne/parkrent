require 'spec_helper'

describe Order do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:order) }
      specify { should be_valid }

      subject { FactoryGirl.create(:order_with_payment) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_order) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should belong_to(:user) }
    it { should belong_to(:rent) }
    it { should belong_to(:vehicle) }
    it { should have_one(:payment).dependent(:destroy) }
  end

  describe :Validations do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:rent) }
    it { should validate_presence_of(:vehicle) }
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end
end
