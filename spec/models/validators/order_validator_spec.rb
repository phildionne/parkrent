require 'spec_helper'

describe OrderValidator do

  let(:order) { build(:order, vehicle: nil) }
  let(:user) { create(:user_with_vehicles) }

  it "validates vehicle belongs to user" do
    order.vehicle = user.vehicles.sample
    order.save

    expect(order).to have(1).error_on(:vehicle)
  end
end
