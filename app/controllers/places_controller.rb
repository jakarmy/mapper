class PlacesController < ApplicationController
  # GET /places
  # GET /places.json
  def index
    @places = Place.all

    # @json = Place.all.to_gmaps4rails do |place, marker|
    #   marker.title   place.name
    #   marker.infowindow "<img src='#{place.image}'><h2>#{place.name}</h2><body>#{place.address}</body>"
    #   marker.sidebar "<span>#{place.name}</span>"
    #   marker.json({ :id => place.id})
    # end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/new
  # GET /places/new.json
  def new
    @place = Place.new
    @trip = Trip.find(params[:trip_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(params[:place])
    trip = Trip.find(params[:trip])
    if (@logged_user.trips.include? trip) 
    trip.places << @place
    respond_to do |format|
      if @place.save
        #format.html { redirect_to @place, notice: 'Place was successfully created.' }
        #We have to determine HOW we'll know WHICH trip we should go back to!!
        format.html { redirect_to trip, notice: 'Place was successfully created.' }
        format.json { render json: @place, status: :created, location: @place }
    #  else
     #   format.html { render action: "new" }
      #  format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  else
    redirect_to logout_path
  end

  end

  # PUT /places/1
  # PUT /places/1.json
  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  def search
    search_string = params[:search]

    @Places = Array.new
    images = Hash.new
    final_result = Hash.new

    if !search_string.nil?
    # First, we look for the exact results
      Place.find(:all, :conditions => ['name LIKE ? ','%'+search_string+'%'], :limit => 10).each do |p|
        @Places << p
      end
      # In this case we'll search for independant words
      # if @Places.count < 10
      #   search_string.split.each do |value|
      #     Place.find(:all, :conditions => ['name LIKE ? ','%'+value+'%'], :limit => 10).each do |p|
      #       @Places << p
      #     end
      #   end
      # end
    end

    @Places.each do |place|
      # This is to quickly associate which set of images is related to which place
      images[place.id] = place.images
    end

    final_result['places'] = @Places
    final_result['images'] = images

    respond_to do |format|
      format.json {
        # resp = Hash.new
        # resp[:json] = render_to_string(:layout => false, :locals => {:users => @Places}, :formats => [:json])
        render :json => final_result
      }
    end

  end
end
