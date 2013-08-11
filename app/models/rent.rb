class Rent < ActiveRecord::Base
  belongs_to :parking

  validates :parking, :price, :beginning, :termination, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :beginning, :date => { :before => :termination }
  validates :beginning, :date => { :after => Proc.new { Time.now }}
  validates_with RentValidator

  def title
    "#{price} - #{beginning} #{termination}"
  end
end
