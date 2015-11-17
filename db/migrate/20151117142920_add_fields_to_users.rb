class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rpps, :string
    add_column :users, :pseudo, :string
    add_column :users, :phone_number, :string
    add_column :users, :contribution, :integer
    add_column :users, :diploma, :integer
    add_column :users, :first_install, :boolean
    add_column :users, :role, :string
  end
end
