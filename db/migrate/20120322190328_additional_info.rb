class AdditionalInfo < ActiveRecord::Migration
  def up
    add_column :users, :roomie_first_name, :string, :null => true
    add_column :users, :roomie_last_name, :string, :null => true
    add_column :users, :guest_supplement, :string
    add_column :users, :guest_trip, :boolean
  end

  def down
  end
end
