class UsersController < ApplicationController
  # GET /users
  # GET /users.json
skip_before_filter :check_token, only: [:new, :create]

  def index
    @user = @logged_user
    redirect_to @user
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    session[:token] = @user.generateToken
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def match
    value = params[:name]
    @nil_return = Hash.new
    @nil_return[:error] = "no results"

    @Users = Array.new

    if !value.nil?
      # This is a user's name
      if value.split.count>1
        User.find(:all, :conditions => ['name LIKE ? AND lastname LIKE ? ','%'+value.split[0]+'%','%'+value.split[1]+'%'], :limit => 10).each do |u|
          @Users << u
        end
# This is an email address
      else
        User.find(:all, :conditions => ['email LIKE ? ', value+'%'],:limit => 10).each do |u|
          @Users << u
        end
        if @Users.count < 10
          User.find(:all, :conditions => ['name LIKE ? ', value+'%'],:limit => 10).each do |u|
          @Users << u
        end
          if @Users.count < 10
            User.find(:all, :conditions => ['lastname LIKE ? ', value+'%'],:limit => 10).each do |u|
          @Users << u
        end
          end
        end
      end

    end
    respond_to do |format|
      format.json { 
        resp = Hash.new
        resp[:html] = render_to_string(:partial => 'suggested_users.html.erb', :layout => false, :locals => {:users => @Users}, :formats => [:html])
        render :json => resp
      }
    end

    
  end
end
