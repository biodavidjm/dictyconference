class AddExcursionTypeToUsers < ActiveRecord::Migration
	def self.up
		add_column :users, :excursion_type, :string
	end

	def self.down
		remove_column :users, :excursion_type
	end
end
