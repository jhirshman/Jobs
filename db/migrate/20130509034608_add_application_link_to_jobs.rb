class AddApplicationLinkToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :application_url, :string
    add_column :jobs, :job_email, :string
    add_column :companies, :logo_url, :string

    remove_column :companies, :formType
  end
end
