class AccommodationType < ActiveRecord::Migration
  def up
    add_column :users, :accommodation_type, :string
  end

  def down
  end
end
