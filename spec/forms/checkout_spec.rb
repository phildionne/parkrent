require 'spec_helper'

describe Checkout do

  describe :Factories do
    context "Valid factory" do
      subject { FactoryGirl.build(:checkout) }
      specify { should be_valid }
    end

    context "Invalid factory" do
      subject { FactoryGirl.build(:invalid_checkout) }
      specify { should_not be_valid }
    end
  end

  describe :Validations do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_presence_of(:license_plate) }
    it { should validate_presence_of(:rent_id) }
  end

  describe :InstanceMethods do
    describe :process do
      before { FactoryGirl.create(:rent) } # Ensure Rent is created before #expect evaluation

      context "with valid attributes" do
        let(:checkout) { FactoryGirl.build(:checkout, rent: Rent.last) }

        it "creates a new user" do
          expect { checkout.process }.to change(User, :count).by(1)
        end

        it "creates a new vehicle" do
          expect { checkout.process }.to change(Vehicle, :count).by(1)
        end

        it "creates a new order" do
          expect { checkout.process }.to change(Order, :count).by(1)
        end
      end

      context "with invalid attributes" do
        let(:checkout) { FactoryGirl.build(:checkout, rent: Rent.last) }

        it "doesn't persist the user" do
          expect { checkout.process }.not_to change(User, :count).by(1)
        end

        it "doesn't persist the vehicle" do
          expect { checkout.process }.not_to change(Vehicle, :count).by(1)
        end

        it "doesn't persist the order" do
          expect { checkout.process }.not_to change(Order, :count).by(1)
        end
      end
    end
  end
end
