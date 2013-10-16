require 'spec_helper'

describe VehicleAuthorizer do

  let(:user) { create(:user_with_vehicles) }

  describe :Class do

    it "lets users read" do
      expect(VehicleAuthorizer).to be_readable_by(user)
    end

    it "lets users create" do
      expect(VehicleAuthorizer).to be_creatable_by(user)
    end
  end

  describe :Instances do
    let(:vehicle) { user.vehicles.sample }

    it "lets users update a belonging vehicle" do
      expect(vehicle.authorizer).to be_updatable_by(user)
    end

    it "lets users delete a belonging vehicle" do
      expect(vehicle.authorizer).to be_deletable_by(user)
    end
  end
end
