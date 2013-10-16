require 'spec_helper'

describe ParkingAuthorizer do

  let(:user) { create(:user_with_parkings) }

  describe :Class do

    it "lets users read" do
      expect(ParkingAuthorizer).to be_readable_by(user)
    end

    it "lets users create" do
      expect(ParkingAuthorizer).to be_creatable_by(user)
    end
  end

  describe :Instances do
    let(:parking) { user.parkings.sample }

    it "lets users update a belonging parking" do
      expect(parking.authorizer).to be_updatable_by(user)
    end

    it "lets users delete a belonging parking" do
      expect(parking.authorizer).to be_deletable_by(user)
    end
  end
end
