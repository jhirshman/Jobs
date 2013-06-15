class IndustriesController < ApplicationController
  # GET /industries
  # GET /industries.json
  def index
    @industries = Industry.all.select {|i| i.companies.size > 0}
    @industries = @industries.sort {|x,y| x.name <=> y.name}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @industries }
    end
  end

  # GET /industries/1
  # GET /industries/1.json
  def show
    @industry = Industry.find(params[:id])
    @jobs = []
    @industry.companies.each do |c|
      @jobs.concat(c.jobs)
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @industry }
    end
  end

  # GET /industries/new
  # GET /industries/new.json
  def new

    return unless representsCompany?

    @industry = Industry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @industry }
    end
  end

  # GET /industries/1/edit
  def edit
    return unless admin?
    @industry = Industry.find(params[:id])
  end

  # POST /industries
  # POST /industries.json
  def create
    return unless representsCompany?

    @industry = Industry.new(params[:industry])

    respond_to do |format|
      if @industry.save
        format.html { redirect_to edit_company_path(current_user.company), notice: 'Industry was successfully created.' }
        format.json { render json: @industry, status: :created, location: @industry }
      else
        format.html { render action: "new" }
        format.json { render json: @industry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /industries/1
  # PUT /industries/1.json
  def update
    return unless admin?
    @industry = Industry.find(params[:id])

    respond_to do |format|
      if @industry.update_attributes(params[:industry])
        format.html { redirect_to @industry, notice: 'Industry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @industry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /industries/1
  # DELETE /industries/1.json
  def destroy
    return unless admin?
    @industry = Industry.find(params[:id])
    @industry.destroy

    respond_to do |format|
      format.html { redirect_to industries_url }
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
