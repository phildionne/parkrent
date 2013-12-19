require 'spec_helper'

describe CommentAuthorizer do
  let(:user) { create(:user) }

  describe :Class do

    context "with a published parking, a user being the client of a parking and no comments on this parking by this user" do
      let(:parking) { parking = create(:order, user: user).rent.parking.tap(&:publish) }

      it "lets users create" do
        expect(CommentAuthorizer).to be_creatable_by(user, :for => parking)
      end
    end
  end
end
