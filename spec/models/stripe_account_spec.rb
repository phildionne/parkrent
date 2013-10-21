require 'spec_helper'

describe Order do

  describe :Factories do
    context "Valid factory" do
      subject { create(:stripe_account) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { build(:invalid_stripe_account) }
      specify { should_not be_valid }
    end
  end

  describe :Associations do
    it { should belong_to(:user) }
  end

  describe :Validations do
    it { should validate_presence_of(:access_token) }
    it { should validate_presence_of(:stripe_user_id) }
    it { should validate_presence_of(:publishable_key) }
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end
end
