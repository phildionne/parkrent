require 'spec_helper'

describe Payment do

  describe :Factories do
    context "Valid factory" do
      subject { create(:payment) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { build(:invalid_payment) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should belong_to(:order) }
    it { should have_one(:user).through(:order) }
  end

  describe :Validations do
    it { should validate_presence_of(:order) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:stripe_charge_id) }
    it { should validate_numericality_of(:amount) }
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end
end
