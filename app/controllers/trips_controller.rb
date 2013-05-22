class TripsController < ApplicationController
  # GET /trips
  # GET /trips.json
  def index
    
    #If the user doesn't exist, then we redirect to index
    unless user = getCurrentUser
        respond_to do |format|
           format.html { redirect_to :root, :notice => "Tienes que haber iniciado sesion!" }
           format.json { render :json => {:ok => false, :notice => "Tienes que haber iniciado sesion!"} }
         end
        return
      end
    
    @trips = user.trips

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trips }
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show

    unless user = getCurrentUser
        respond_to do |format|
           format.html { redirect_to :root, :notice => "Tienes que haber iniciado sesion!" }
           format.json { render :json => {:ok => false, :notice => "Tienes que haber iniciado sesion!"} }
         end
        return
    end

    @trip = Trip.find(params[:id])
    @places = @trip.places

    @json = @places.to_gmaps4rails do |place, marker|
      marker.title   place.name
      marker.infowindow "<img src='#{place.image}'><h2>#{place.name}</h2><body>#{place.address}</body>"
      marker.sidebar "<span>#{place.name}</span>"
      marker.json({ :id => place.id})
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/new
  # GET /trips/new.json
  def new
    @trip = Trip.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/1/edit
  def edit
    @trip = Trip.find(params[:id])
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(params[:trip])

    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render json: @trip, status: :created, location: @trip }
      else
        format.html { render action: "new" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trips/1
  # PUT /trips/1.json
  def update
    @trip = Trip.find(params[:id])

    respond_to do |format|
      if @trip.update_attributes(params[:trip])
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
    end
  end
  def add_place

    unless user = getCurrentUser
        respond_to do |format|
           format.html { redirect_to :root, :notice => "Tienes que haber iniciado sesion!" }
           format.json { render :json => {:ok => false, :notice => "Tienes que haber iniciado sesion!"} }
         end
        return
    end

    @trip = Trip.find(params[:id])

    respond_to do |format|
      format.html {redirect_to :new_place}
      format.json { render json: @trip }
    end
  end
end