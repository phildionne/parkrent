require 'spec_helper'

describe ParkingAuthorizer do
  let(:user) { create(:user) }

  describe :Class do

    it "lets users create" do
      expect(ParkingAuthorizer).to be_creatable_by(user)
    end
  end

  describe :Instances do

    context "with a belonging parking" do
      let(:parking) { create(:parking, user: user) }

      it "lets users read" do
        expect(parking.authorizer).to be_readable_by(user)
      end

      it "lets users update" do
        expect(parking.authorizer).to be_updatable_by(user)
      end

      it "lets users delete" do
        expect(parking.authorizer).to be_deletable_by(user)
      end
    end

    context "with a published parking" do
      let(:parking) { create(:parking, :published) }

      it "lets users read" do
        expect(parking.authorizer).to be_readable_by(user)
      end
    end
  end
end
