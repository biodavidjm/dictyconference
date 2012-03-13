class AddColumns2Users < ActiveRecord::Migration
  def up
    add_column :users, :city, :string
    add_column :users, :zipcode, :string
  end

  def down
  end
end
