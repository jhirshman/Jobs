class Job < ActiveRecord::Base
  attr_accessible :description, :expiration_date, :title, :application_url, :job_email
  belongs_to :category
  has_many :applications
  belongs_to :location
  belongs_to :company


  def externalLink?
  	if self.application_url.nil? or self.application_url.empty?
  		return false
		else
			return true
		end
	end

	def expired?
		not self.expiration_date.nil? and self.expiration_date < Date.today
	end
end
