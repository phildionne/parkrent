require 'spec_helper'

describe RentAuthorizer do
  let(:user) { create(:user_with_parkings_and_rents) }

  describe :Class do

    it "lets users read" do
      expect(RentAuthorizer).to be_readable_by(user)
    end
  end

  describe :Instances do

    context "with a belonging rent" do
      let(:rent) { user.rents.sample }

      it "lets users create" do
        expect(rent.authorizer).to be_creatable_by(user)
      end

      it "lets users update" do
        expect(rent.authorizer).to be_updatable_by(user)
      end

      it "lets users delete" do
        expect(rent.authorizer).to be_deletable_by(user)
      end
    end
  end
end
