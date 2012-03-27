class ChangePaymentDueDatatype < ActiveRecord::Migration
  def up
    change_column :users, :payment_due, :decimal
  end

  def down
  end
end
