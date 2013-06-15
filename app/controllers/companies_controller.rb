class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.json

  def index

    if current_user.nil? or current_user.company.nil?
      render :noCompany
      return
    end

    @company = current_user.company
    @name = @company.name
    @jobs = @company.jobs

    @customAlert = checkProfile(@company)
    #@companies = Company.all

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render json: @companies }
    #end
  end

  def noCompanyl
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])
    @jobs = @company.jobs
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    return unless admin?

    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
    @industries = Industry.all
    authenticate(@company)

  end

  # POST /companies
  # POST /companies.json
  def create
    return unless admin?

    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])
    authenticate(@company)

    @company.industry = Industry.find_by_name(params[:industry])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to Company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    return unless admin?

    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end



  def authenticate(company)
    if current_user.nil? or current_user.company.nil? or not company.eql?(current_user.company)
      redirect_to "/", :alert=>"You do not have access to this company"
    end 
  end


  def admin?
    if current_user.nil? or not current_user.admin
      redirect_to "/", :alert=>"You do not have access to this page"
      return false
    end
    return true
  end

  def checkProfile(company)
    message = "Your company profile is missing the following: "
    numMissing = 1
    if company.companyDescription.nil? or company.companyDescription.size == 0
      message += "(#{numMissing}) "
      numMissing += 1
      message += "a Company Description, "
    end
    if company.logo_url.nil? or company.logo_url.size == 0
      message += "(#{numMissing}) "
      numMissing += 1
      message += "a Logo, "
    end
    if company.url.nil? or company.url.size == 0
      message += "(#{numMissing}) "
      numMissing += 1
      message += "a URL, "
    end
    if company.industry.nil? or company.industry.name.size == 0
      message += "(#{numMissing}) "
      numMissing += 1
      message += "an Industry, "
    end
  end

end
