require 'spec_helper'

describe OrderValidator do

  describe :validate_rent_doesnt_belongs_to_user do
    let(:user)  { create(:user_with_parkings_and_rents) }
    let(:order) { build(:order, user: user, rent: user.rents.sample) }

    it "validates rent doesn't belongs to user" do
      order.valid?
      expect(order).to have(1).error_on(:rent)
    end
  end

  describe :validate_vehicle_belongs_to_user do
    let(:user)    { create(:user) }
    let(:vehicle) { create(:vehicle) }
    let(:order)   { build(:order, user: user, vehicle:vehicle) }

    it "validates vehicle belongs to user" do
      order.valid?
      expect(order).to have(1).error_on(:vehicle)
    end
  end
end
