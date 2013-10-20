require 'spec_helper'

describe VehicleAuthorizer do
  let(:user) { create(:user) }

  describe :Class do

    it "lets users read" do
      expect(VehicleAuthorizer).to be_readable_by(user)
    end

    it "lets users create" do
      expect(VehicleAuthorizer).to be_creatable_by(user)
    end
  end

  describe :Instances do

    describe "with a belonging vehicle" do
      let(:vehicle) { create(:vehicle, user: user) }

      it "lets users update" do
        expect(vehicle.authorizer).to be_updatable_by(user)
      end

      it "lets users delete" do
        expect(vehicle.authorizer).to be_deletable_by(user)
      end
    end
  end
end
