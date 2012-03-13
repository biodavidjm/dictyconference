class IsRegistered < ActiveRecord::Migration
  def up
    add_column :users, :is_registered, :boolean
  end

  def down
  end
end
