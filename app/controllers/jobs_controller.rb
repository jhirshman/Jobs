class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])
    @company = @job.company
    @location = @job.location.name unless @job.location.nil?

    if @job.externalLink?
      link = @job.application_url
      if link =~ /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
        @externalLinkDisplay = link
        @externalLinkHREF = "mailto:#{link}"
      else
        @externalLinkDisplay = link
        @externalLinkHREF = /^http/.match(link) ? link : "http://#{link}"
      end
    end

    @ownsJob = canEdit?(@job)


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    return unless representsCompany?
    @new = true

    @job = Job.new(:expiration_date => Date.today.next_month(2))

    @categories = []
    Category.all.each {|c| @categories.append(c.name)}
    @locations = []
    Location.all.each {|c| @locations.append(c.name)}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    return unless representsCompany?

    @categories = []
    Category.all.each {|c| @categories.append(c.name)}
    @locations = []
    Location.all.each {|c| @locations.append(c.name)}

    @job = Job.find(params[:id])
    return unless canEdit?(@job)
  end

  # POST /jobs
  # POST /jobs.json
  def create
    return unless representsCompany?

    @job = Job.new(params[:job])
    @job.category = Category.find_by_name(params[:category])
    @job.location = Location.find_by_name(params[:location])
    @job.company = current_user.company

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    return unless representsCompany?

    @job = Job.find(params[:id])
    return unless canEdit?(@job)
    @job.category = Category.find_by_name(params[:category])
    @job.location = Location.find_by_name(params[:location])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    return unless representsCompany?

    @job = Job.find(params[:id])
    return unless canEdit?(@job)

    @job.destroy

    respond_to do |format|
      format.html { redirect_to '/companies' }
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

  def canEdit?(job)
    if current_user.nil?
      return false
    end
    if current_user.admin
      return true
    end
    if not current_user.company.nil? and current_user.company.eql?(job.company)
      return true
    end
    return false
  end


end
