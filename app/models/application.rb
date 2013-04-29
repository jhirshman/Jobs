class Application < ActiveRecord::Base
  attr_accessible :email, :lastPosition, :lastTitle, :links, :name, :phone, :resume
  belongs_to :job

  validates :email, :presence => true
  validates :name, :presence => true
  validates :phone, :presence => true

  validates_format_of :email, :with=> /\A[^@]+@([^@]+\.)+[^@\.]+\z/

end
