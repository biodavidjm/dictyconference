class BillingId < ActiveRecord::Migration
  def up
    add_column :users, :billing_id, :string
  end

  def down
  end
end
