require 'spec_helper'

describe RentAuthorizer do

  let(:user) { create(:user_with_parkings_and_rents) }

  describe :Class do

    it "lets users read" do
      expect(RentAuthorizer).to be_readable_by(user)
    end
  end

  # @TODO Add publishable?
  describe :Instances do
    let(:rent) { user.rents.sample }

    it "lets users create a belonging rent" do
      expect(rent.authorizer).to be_creatable_by(user)
    end

    it "lets users update a belonging rent" do
      expect(rent.authorizer).to be_updatable_by(user)
    end

    it "lets users delete a belonging rent" do
      expect(rent.authorizer).to be_deletable_by(user)
    end
  end
end
