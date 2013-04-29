class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :name
      t.string :lastPosition
      t.string :lastTitle
      t.string :phone
      t.string :email
      t.text :resume
      t.text :links

      t.integer :job_id

      t.timestamps
    end
  end
end
