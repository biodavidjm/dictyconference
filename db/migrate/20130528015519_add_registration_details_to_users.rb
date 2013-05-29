class AddRegistrationDetailsToUsers < ActiveRecord::Migration
	def self.up
		add_column :users, :city, :string
		add_column :users, :zipcode, :string
		add_column :users, :country, :string
		add_column :users, :passport, :string
		add_column :users, :phone, :string
		add_column :users, :institute, :string
		add_column :users, :address, :string
		add_column :users, :is_registered, :boolean
		add_column :users, :accommodation_type, :string
		add_column :users, :has_guest, :boolean
		add_column :users, :roomie_first_name, :string, :null => true
		add_column :users, :roomie_last_name, :string, :null => true
		add_column :users, :guest_supplement, :string
		add_column :users, :guest_trip, :boolean
		add_column :users, :guest_supplement_HB, :boolean
		add_column :users, :guest_supplement_HBD, :boolean
		add_column :users, :extra_accommodation, :boolean
		add_column :users, :check_in, :date
		add_column :users, :check_out, :date
		add_column :users, :comment, :text
		add_column :users, :payment_due, :string
	end

	def self.down
		remove_column :users, :city
		remove_column :users, :zipcode
		remove_column :users, :country
		remove_column :users, :passport
		remove_column :users, :phone
		remove_column :users, :institute
		remove_column :users, :address
		remove_column :users, :is_registered
		remove_column :users, :accommodation_type
		remove_column :users, :has_guest
		remove_column :users, :roomie_first_name
		remove_column :users, :roomie_last_name
		remove_column :users, :guest_supplement
		remove_column :users, :guest_trip
		remove_column :users, :guest_supplement_HB
		remove_column :users, :guest_supplement_HBD
		remove_column :users, :extra_accommodation
		remove_column :users, :check_in
		remove_column :users, :check_out
		remove_column :users, :comment
		remove_column :users, :payment_due
	end
end
