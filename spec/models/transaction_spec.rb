require 'spec_helper'

describe Transaction do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:transaction) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_transaction) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
  end

  describe :Validations do
    it { should validate_presence_of(:rent) }
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end

end
