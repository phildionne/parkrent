require 'spec_helper'

class Validatable
  include ActiveModel::Validations
  validates_with ParkingValidator
end

describe ParkingValidator do

  subject { Validatable.new }

  context "for a valid record" do
  end

  context "for an invalid record" do
    describe "with overlapping rents periods" do
    end
  end
end
