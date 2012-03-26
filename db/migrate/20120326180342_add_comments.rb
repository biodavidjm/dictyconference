class AddComments < ActiveRecord::Migration
  def up
    add_column :users, :comment, :text
  end

  def down
  end
end
