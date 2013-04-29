class AddLocationIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :location_id, :integer
  end
end
