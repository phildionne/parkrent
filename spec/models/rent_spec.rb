require 'spec_helper'

describe Rent do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.create(:rent) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_rent) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should belong_to(:parking) }
  end

  describe :Validations do
    it { should validate_presence_of(:parking) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:beginning) }
    it { should validate_presence_of(:termination) }
    it { should validate_numericality_of(:price) }
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end

end
