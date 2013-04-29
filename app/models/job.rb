class Job < ActiveRecord::Base
  attr_accessible :description, :expiration_date, :title
  belongs_to :category
  has_many :applications
  belongs_to :location
  belongs_to :company
end
