require 'spec_helper'

describe LineItem do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:line_item) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_line_item) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should belong_to(:order) }
  end

  describe :Validations do
    it { should validate_presence_of(:order) }
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end

end
