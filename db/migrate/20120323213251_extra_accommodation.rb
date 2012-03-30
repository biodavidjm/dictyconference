class ExtraAccommodation < ActiveRecord::Migration
  def up
    add_column :users, :extra_accommodation, :boolean
    add_column :users, :check_in, :date
    add_column :users, :check_out, :date
  end

  def down
  end
end
