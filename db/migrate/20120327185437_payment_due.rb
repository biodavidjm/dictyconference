class PaymentDue < ActiveRecord::Migration
  def up
    add_column :users, :payment_due, :float
  end

  def down
  end
end
