module TripsHelper

	def getRecomendedTrips()
		trips = Trip.all
		rec_trips = Array.new

		unless @logged_user
			return trips
		end

		trips.each do |t|
			if(!(trips.users.include? @logged_user){
				rec_trips << t
			}
		end

		return rec_trips

	end

end
