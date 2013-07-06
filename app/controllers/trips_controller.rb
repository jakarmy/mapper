class TripsController < ApplicationController
  helper :application
  # GET /trips
  # GET /trips.json
  def index
       
    @trips = @logged_user.trips

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trips }
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show

    @trip = Trip.find(params[:id])
    @places = @trip.places
    @has_map = false
    if (@logged_user.trips.include? @trip) 
      @has_map = true
      @invite = true;
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/new
  # GET /trips/new.json
  def new
    create
  end

  # GET /trips/1/edit
  def edit
    @trip = Trip.find(params[:id])
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(params[:trip])
    @trip.name = "NEW_TRIP"

    respond_to do |format|
      if @trip.save
        @logged_user.trips << @trip
        format.html { redirect_to @trip, notice: 'Trip was successfully created.', new_trip: true }
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
    
    if @logged_user.trips.include? @trip
      name_hash = Hash.new
      unless params.has_key? :trip
        puts "No Params"
        name_hash[:name] = params[:name]
        @trip.update_attributes(name_hash)
      end
    respond_to do |format|
      if @trip.update_attributes(params[:trip]) || @trip.update_attributes(name_hash)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
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

    @trip = Trip.find(params[:id])
    place = Place.find(params[:place_id])
    if (!(@logged_user.trips.include? @trip))
      format.html { redirect_to @trip, notice: 'You can not add places to this trip' }
      return
    end
    @trip.places << place

    if @trip.save
      respond_to do |format|
        format.html { redirect_to @trip, notice: place.name + ' added' }
        format.json { render json: @trip }
      end
    else
      respond_to do |format|
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_place

    @trip = Trip.find(params[:id])
    place = Place.find(params[:place_id])
    if (!(@logged_user.trips.include? @trip))
      format.html { redirect_to @trip, notice: 'You can not delete places from this trip' }
      return
    end

    @trip.places.delete(place)

    if @trip.save
      respond_to do |format|
        format.html { redirect_to @trip, notice: place.name + ' deleted' }
        format.json { render json: @trip }
      end
    else
      respond_to do |format|
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def invite

    @trip = Trip.find(params[:id])

    @user_ids = params[:invited]
    @users = Array.new
    unless params.has_key?(:invited)
      redirect_to @trip, :notice => "No users selected for invites"
      return
    end
    @user_ids.each do |user_id|
      @users << User.find(user_id)
    end
    @users_mails = params[:invitation_mail].gsub(/\s+/, "").split(",")
    
    unless @users.count > 0 || @users_mails.size > 0
      respond_to do |format|
        format.html { redirect_to @trip, :notice => "Not enough permissions!" }
        format.json { render :json => {:ok => false, :notice => "Not enough permissions!"} }
      end
      return
    end
    
    if @users
      @users.each do |user|
        unless user.trips.include? @trip
          user.trips << @trip
          user.save
        end
      end
    end
    
    if @users_mails.size > 0
      @users_mails.each do |mail|
        if mail.size > 0
          if user = User.find_by_email(mail)
            unless user.trips.include? @trip
              user.trips << @trip
              user.save

                            #invite = Invite.new
#              invite.user_id = user.id
#              invite.gathering_id = @gathering.id
#              invite.creator = false
#              invite.organizer = false
#              invite.assist = 0
#              invite.save

              #mail_params = {:user => user , :gathering => @gathering}

              #Emailer.event_invite_email(mail_params).deliver
            end

          else

            #Send Emails!!
            
            #pi = PendingInvites.new
#            pi.invite_type = 1
#            pi.invitation_id = @gathering.id
#            pi.usermail = mail
#            pi.save
            
            #mail_params = {:user_mail => mail , :gathering => @gathering}

            #Emailer.event_invite_email(mail_params).deliver
        end
      end
    end
  end
    respond_to do |format|
      format.html { redirect_to @trip, :notice => "You have invited succesfully" }
      format.json
    end
  end

end
