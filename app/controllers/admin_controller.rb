class AdminController < ApplicationController
	def adminPanel
		return unless admin?
		@users = User.all
		@companies = Company.all
	end

	def newCompany
		#return unless admin?

		c = Company.new
		c.name = params[:CompanyName]

		c.save

		redirect_to "/admin", :notice=>"You Have added #{c.name}"
	end

	def assignUserToCompany
		return unless admin?

		u = User.find(params[:user])
		c = Company.find(params[:company])

		u.company = c
		u.save

		redirect_to "/admin", :notice=>"You Have put #{u.email} in charge of #{c.name}"
	end

	def admin?
    if current_user.nil? or not current_user.admin
      redirect_to "/", :alert=>"You do not have access to this page"
      return false
    end
    return true
  end
end
