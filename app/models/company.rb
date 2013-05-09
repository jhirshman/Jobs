class Company < ActiveRecord::Base
  attr_accessible :companyDescription, :logo_url, :name, :url
  has_many :users
  has_many :jobs
end
