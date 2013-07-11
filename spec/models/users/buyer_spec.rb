require 'spec_helper'

describe Buyer do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:buyer) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_buyer) }
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
