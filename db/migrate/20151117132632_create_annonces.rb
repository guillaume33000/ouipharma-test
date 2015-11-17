class CreateAnnonces < ActiveRecord::Migration
  def change
    create_table :annonces do |t|
      t.string :title
      t.string :description
      t.string :picture
      t.string :region
      t.string :department
      t.string :city
      t.string :address
      t.integer :turnover
      t.string :margin
      t.integer :payroll
      t.string :team
      t.integer :total_area
      t.integer :sales_area
      t.string :healthcare_setting
      t.boolean :parking
      t.boolean :walls
      t.string :environment

      t.timestamps null: false
    end
  end
end
