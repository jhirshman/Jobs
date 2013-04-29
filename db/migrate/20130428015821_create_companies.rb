class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :url
      t.string :formType
      t.text :companyDescription

      t.timestamps
    end

    add_index :companies, :name
  end
end
