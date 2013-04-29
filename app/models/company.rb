class Company < ActiveRecord::Base
  attr_accessible :companyDescription, :formType, :name, :url
  has_many :users
  has_many :jobs
end
