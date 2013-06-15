class AddIndustryIdToCompany < ActiveRecord::Migration
  def change
	  add_column :companies, :industry_id, :integer
  end
end
