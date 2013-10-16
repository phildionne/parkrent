require 'spec_helper'

describe OrderAuthorizer do
  let(:user) { create(:user) }

  describe :Class do

    it "lets users create" do
      expect(OrderAuthorizer).to be_creatable_by(user)
    end
  end

  describe :Instances do
    let(:order) { create(:order, user: user) }

    it "lets users read a belonging order" do
      expect(order.authorizer).to be_readable_by(user)
    end

    it "lets users update a belonging order" do
      expect(order.authorizer).to be_updatable_by(user)
    end

    it "lets users delete a belonging order" do
      expect(order.authorizer).to be_deletable_by(user)
    end
  end
end
