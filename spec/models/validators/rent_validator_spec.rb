require 'spec_helper'

class Validatable
  include ActiveModel::Validations
  validates_with RentValidator
end

describe RentValidator do

  subject { Validatable.new }

  context "for a valid record" do
  end

  context "for an invalid record" do
  end
end
