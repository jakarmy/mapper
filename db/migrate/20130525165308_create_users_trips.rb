class CreateUsersTrips < ActiveRecord::Migration
  def change
    create_table 'trips_users', :id => false do |t|
      t.integer :user_id
      t.integer :trip_id
    end
  end
end
