class ModifyAdditionalInfo < ActiveRecord::Migration
  def up
    remove_column :users, :guest_supplement
    add_column :users, :guest_supplement_HB, :boolean
    add_column :users, :guest_supplement_HBD, :boolean
  end

  def down
  end
end
