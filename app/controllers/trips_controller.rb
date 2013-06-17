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
        @logged_user.trips << @trip
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

    @trip = Trip.find(params[:id])

    respond_to do |format|
      format.html {redirect_to :new_place}
      format.json { render json: @trip }
    end
  end

  def invite

    @trip = Trip.find(params[:id])

    @user_ids = params[:invited]
    @users = Array.new
    @user_ids.each do |user_id|
      @users << User.find(user_id)
    end
    @users_mails = params[:invitation_mail].gsub(/\s+/, "").split(",")
    
    unless @users.count > 0 || @users_mails.size > 0
      respond_to do |format|
        format.html { redirect_to @trip, :notice => "No tienes permiso para acceder aqui!" }
        format.json { render :json => {:ok => false, :notice => "No tienes permiso para acceder aqui!"} }
      end
      return
    end
    
    if @users
      @users.each do |user|
        unless user.trips.include? @trip
          user.trips << @trip
          user.save
        end
          #invite = Invite.new
#          invite.user_id = user
#          invite.gathering_id = @gathering.id
#          invite.creator = false
#          invite.organizer = false
#          invite.assist = 0
#          invite.save
          
          #mail_params = {:user => User.find(user) , :gathering => @gathering}

          #Emailer.event_invite_email(mail_params).deliver
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
      format.html { redirect_to @trip, :notice => "Has invitado con exito!" }
      format.json
    end
  end

end
