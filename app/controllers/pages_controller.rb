class PagesController < ApplicationController
	def main
	end
	def user
		if current_user.nil?
			redirect_to "/"
		elsif current_user.company.nil?
			render :action => :user_explanation
		else
			redirect_to "/companies"
		end
	end
	def user_explanation
	end
end
