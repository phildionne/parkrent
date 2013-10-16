require 'spec_helper'

describe PaymentAuthorizer do
  let(:order) { create(:order) }
  let(:user)  { order.user }

  describe :Class do

    it "lets users create" do
      expect(PaymentAuthorizer).to be_creatable_by(user)
    end
  end

  describe :Instances do
    let(:payment) { create(:payment, order: order) }

    it "lets users read a belonging payment" do
      expect(payment.authorizer).to be_readable_by(user)
    end

    it "lets users update a belonging payment" do
      expect(payment.authorizer).to be_updatable_by(user)
    end

    it "lets users delete a belonging payment" do
      expect(payment.authorizer).to be_deletable_by(user)
    end
  end
end
