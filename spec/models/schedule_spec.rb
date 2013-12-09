require 'spec_helper'

describe Schedule do

  describe :Factories do
    context "Valid factory" do
      subject { build(:schedule) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { build(:invalid_schedule) }
      specify { should_not be_valid }
    end
  end

  describe :Validations do
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
    it { should respond_to(:daily_start_hour) }
    it { should respond_to(:daily_start_hour=) }
    it { should respond_to(:daily_end_hour) }
    it { should respond_to(:daily_end_hour=) }
    it { should respond_to(:weekend) }
    it { should respond_to(:weekend=) }
  end
end
