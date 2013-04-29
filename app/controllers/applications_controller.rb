class ApplicationsController < ApplicationController
  # GET /applications
  # GET /applications.json
  def index
    return unless admin?

    @applications = Application.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end

  # GET /applications/job/1
  def showForJob
    return unless appAccess?(params[:id])
    
    @job = Job.find(params[:id])
    @applications = @job.applications

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
    @application = Application.find(params[:id])
        
    return unless appAccess?(@application.job.id)

    @job = @application.job

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @application }
    end
  end

  # GET /applications/new
  # GET /applications/new.json
  def new
    if params[:id].nil?
      redirect_to "/", :alert=>"You need to apply through a job"
      return
    end

    @job = Job.find(params[:id])
    @company = @job.company.name
    @title = @job.title

    @application = Application.new

    respond_to do |format|
      format.html# new.html.erb
      format.json { render json: @application }
    end
  end

  # GET /applications/1/edit
  def edit
    return unless admin?
    @application = Application.find(params[:id])
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(params[:application])
    @application.job = Job.find(params[:id])
    respond_to do |format|
      if @application.save
        format.html { redirect_to '/', notice: 'Application was received.' }
        format.json { render json: @application, status: :created, location: @application }
      else
        @job = Job.find(params[:id])
        @company = @job.company.name
        @title = @job.title
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /applications/1
  # PUT /applications/1.json
  def update
    return unless admin?
    @application = Application.find(params[:id])

    respond_to do |format|
      if @application.update_attributes(params[:application])
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application = Application.find(params[:id])
    return unless appAccess?(@application.job.id)
    id = @application.job.id
    @application.destroy

    respond_to do |format|
      format.html { redirect_to show_apps_path(:id=>id) }
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

  def appAccess?(jobId)
    if params[:id].nil? || jobId.nil?
      redirect_to "/", :alert=>"You need to view applications for a specific job"
      return false
    end

    if current_user.nil?
      redirect_to "/", :alert=>"You do not have access to this page"
      return false
    end

    if current_user.admin
      return true
    end

    job = Job.find(jobId)
    unless job.company.eql? current_user.company
      redirect_to "/", :alert=>"You do not have access to this page"
      return false
    end

    return true
  end
end
