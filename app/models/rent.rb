class Rent < ActiveRecord::Base
  belongs_to :parking

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000 }
  validates :parking, :price, :beginning, :termination, presence: true
  validates :beginning, :date => { :before => :termination }
  validates :beginning, :date => { :after => Proc.new { Time.now }}
  validates_with RentValidator

  def title
    "#{price.format} - #{beginning.to_formatted_s(:short)} #{termination.to_formatted_s(:short)}"
  end
end
