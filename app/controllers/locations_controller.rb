class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])
    @jobs = @location.jobs

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new

    return unless representsCompany?

    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    return unless admin?
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    return unless representsCompany?

    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to new_job_path, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    return unless admin?
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    return unless admin?
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end

  def admin?
    if current_user.nil? or not current_user.admin
      redirect_to "/", :alert=>"You do not have access to this page"
      return false
    end
    return true
  end

  def representsCompany?
    if current_user.nil?
      redirect_to "/", :alert=>"You do not have access to this page"
      return false
    end
    if current_user.company.nil?
      redirect_to "/", :alert=>"You need to be associated with a company in order to create or edit a job"
      return false
    end

    return true
  end
end
