class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.date :expiration_date

      t.integer :category_id

      t.timestamps
    end

    add_index :jobs, :category_id
  end
end
