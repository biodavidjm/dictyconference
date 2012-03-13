class AddUserAddress < ActiveRecord::Migration
  def up
    add_column :users, :address, :string
  end

  def down
  end
end
