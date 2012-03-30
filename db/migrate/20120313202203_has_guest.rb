class HasGuest < ActiveRecord::Migration
  def up
    add_column :users, :has_guest, :boolean
  end

  def down
  end
end
