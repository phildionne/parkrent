require 'spec_helper'

describe GuestUser do
  let(:guest_user) { build(:guest_user) }

  describe :InstanceMethods do
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:phone_number) }
    it { should respond_to(:email) }
    it { should respond_to(:full_name) }
    it { should respond_to(:orders) }
    it { should respond_to(:parkings) }
    it { should respond_to(:vehicles) }
    it { should respond_to(:rents) }
    it { should respond_to(:sales) }
    it { should respond_to(:authenticated?) }
    it { should respond_to(:persisted?) }

    it { should_not be_authenticated }
    it { should_not be_persisted }

    it { expect(guest_user.orders).to be_kind_of(ActiveRecord::Relation) }
    it { expect(guest_user.parkings).to be_kind_of(ActiveRecord::Relation) }
    it { expect(guest_user.vehicles).to be_kind_of(ActiveRecord::Relation) }
    it { expect(guest_user.rents).to be_kind_of(ActiveRecord::Relation) }
    it { expect(guest_user.sales).to be_kind_of(ActiveRecord::Relation) }
  end
end
