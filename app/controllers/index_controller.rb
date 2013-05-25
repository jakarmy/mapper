class IndexController < ApplicationController

	skip_before_filter :check_token
  before_filter :getLoggedUser

  def getLoggedUser
    if(session[:token]!=nil)
      @logged_user = User.find_by_token(session[:token])
    end
  end

  def getRecomendedTrips
    trips = Trip.all
    rec_trips = Array.new

    unless @logged_user
      return trips
    end

    trips.each do |t|
      if(!(t.users.include? @logged_user))
        rec_trips << t
      end
    end

    return rec_trips

  end

	def index
		@trips = getRecomendedTrips

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @trips }
	    end
	end
end
