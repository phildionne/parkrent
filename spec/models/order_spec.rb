require 'spec_helper'

describe Order do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:order) }
      specify { should be_valid }

      subject { FactoryGirl.create(:order_with_payment) }
      specify { should be_valid }
    end

    context "Valid factory" do
      subject { FactoryGirl.create(:order_with_line_items) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_order) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should have_many(:line_items).dependent(:destroy) }
    it { should have_many(:payments).dependent(:destroy) }
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
