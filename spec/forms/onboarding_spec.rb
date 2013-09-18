require 'spec_helper'

describe Onboarding do

  describe :Factories do
    context "Valid factory" do
      subject { build(:onboarding) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { build(:invalid_onboarding) }
      specify { should_not be_valid }
    end
  end

  # @note There is no presence validation spec for 'price' attribute because
  # of the way #monetize overrides the #price and #price= method
  describe :Validations do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:location,) }
    it { should validate_presence_of(:beginning) }
    it { should validate_presence_of(:termination) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
  end

  describe :InstanceMethods do
    describe :register do
      context "with valid attributes" do
        let(:onboarding) { build(:onboarding) }

        it "creates a new user" do
          expect { onboarding.register }.to change(User, :count).by(1)
        end

        it "creates a new rent" do
          expect { onboarding.register }.to change(Rent, :count).by(1)
        end

        it "creates a new parking" do
          expect { onboarding.register }.to change(Parking, :count).by(1)
        end
      end

      context "with invalid attributes" do
        let(:onboarding) { build(:onboarding, location: nil) }

        it "doesn't persist the user" do
          expect { onboarding.register }.not_to change(User, :count).by(1)
        end

        it "doesn't persist the rent" do
          expect { onboarding.register }.not_to change(Rent, :count).by(1)
        end

        it "doesn't persist the parking" do
          expect { onboarding.register }.not_to change(Parking, :count).by(1)
        end
      end
    end
  end

end
