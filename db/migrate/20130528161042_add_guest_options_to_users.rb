class AddGuestOptionsToUsers < ActiveRecord::Migration
	def self.up
		add_column :users, :guest_single_no_BDB, :boolean
		add_column :users, :guest_single_BDB, :boolean
		add_column :users, :guest_double_no_BDB, :boolean
		add_column :users, :guest_double_BDB, :boolean
	end

	def self.down
		remove_column :users, :guest_single_no_BDB, :boolean
		remove_column :users, :guest_single_BDB, :boolean
		remove_column :users, :guest_double_no_BDB, :boolean
		remove_column :users, :guest_double_BDB, :boolean
	end
end
