class ChangePaymentDueDatatypeAgain < ActiveRecord::Migration
  def up
  change_column :users, :payment_due, :decimal,  :precision => 8, :scale => 2
  end

  def down
  end
end
