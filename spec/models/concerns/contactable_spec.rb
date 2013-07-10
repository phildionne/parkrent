require 'spec_helper'

class Contact
  include ActiveModel::Validations
  include Contactable

  attr_accessor :first_name, :last_name, :phone_number, :email
end

describe Contact do

  describe :Associations do
  end

  describe :Validations do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:email) }
  end

  describe :Callbacks do
  end

  describe :ClassMethods do
  end

  describe :InstanceMethods do
  end

end
