class CreatePlacesTrips < ActiveRecord::Migration
  def change
    create_table 'places_trips', :id => false do |t|
      t.integer :place_id
      t.integer :trip_id
    end
  end
end
