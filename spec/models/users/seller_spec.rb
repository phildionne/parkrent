require 'spec_helper'

describe Seller do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:seller) }
      specify { should be_valid }

      subject { FactoryGirl.create(:seller_with_parkings) }
      specify { should be_valid }

      subject { FactoryGirl.create(:seller_with_parkings_and_rents) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_seller) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should have_many(:parkings).dependent(:destroy) }
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
