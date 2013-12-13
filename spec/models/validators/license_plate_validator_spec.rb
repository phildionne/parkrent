require 'spec_helper'

class Validatable
  include ActiveModel::Validations
  attr_accessor :license_plate
  validates :license_plate, license_plate: true
end

describe LicensePlateValidator do

  subject { Validatable.new }

  context "with a valid license_plate" do
    let(:license_plates) do
      [
        'A00 ABC',
        '000 ABC',
        'ABC 000',
        '000H000',
        'CC 000',
        'CD 000',
        'A00ABC',
        '000ABC',
        'ABC000',
        '000H000',
        'CC000',
        'CD000'
      ]
    end

    it "validates the license_plate" do
      license_plates.each do |license_plate|
        subject.license_plate = license_plate
        should be_valid
      end
    end
  end

  context "with an invalid license_plate" do
    let(:license_plates) do
      [
        '000 000',
        'ABC ABC',
        '000 ABCD',
        '0000 ABC',
        '000000',
        'ABCABC',
        '000ABCD',
        '0000ABC'
      ]
    end

    it "validates the license_plate" do
      license_plates.each do |license_plate|
        subject.license_plate = license_plate
        should_not be_valid
      end
    end

    it "adds an error to the model" do
      license_plates.each do |license_plate|
        subject.license_plate = license_plate
        should have(1).error_on(:license_plate)
      end
    end

  end
end
