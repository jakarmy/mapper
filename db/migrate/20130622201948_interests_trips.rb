class InterestsTrips < ActiveRecord::Migration
  def change
    create_table "interests_trips" do |t|
      t.integer :interest_id
      t.integer :trip_id
  	end
  end
end
