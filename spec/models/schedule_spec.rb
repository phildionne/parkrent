require 'spec_helper'

describe Schedule do

  describe :Factories do
    context "Valid factory" do
      subject { create(:schedule) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { build(:invalid_schedule) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should belong_to(:rent) }
    it { should have_one(:parking).through(:rent) }
  end

  describe :Validations do
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:daily_start_hour) }
    it { should validate_presence_of(:daily_end_hour) }
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end
end
