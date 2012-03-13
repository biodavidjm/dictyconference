class AddColumns2UsersAgain < ActiveRecord::Migration
  def up
    add_column :users, :country, :string
    add_column :users, :passport, :string
    add_column :users, :phone, :string
    add_column :users, :institute, :string
    add_column :users, :address, :string
  end

  def down
  end
end
