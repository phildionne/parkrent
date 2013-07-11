require 'spec_helper'

describe Seller do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:seller) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_seller) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
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
