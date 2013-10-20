class AddItineraryToParkings < ActiveRecord::Migration
  def change
    add_column :parkings, :itinerary, :text
  end
end
