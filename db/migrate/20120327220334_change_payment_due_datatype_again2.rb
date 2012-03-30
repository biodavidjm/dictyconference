class ChangePaymentDueDatatypeAgain2 < ActiveRecord::Migration
  def up
    change_column :users, :payment_due, :string
  end

  def down
  end
end
