class AddAuthlogicDetailsTable < ActiveRecord::Migration
  def self.up
		add_column :users, :crypted_password,   :string               # Authlogic field
		add_column :users, :password_salt,      :string               # Authlogic field
		add_column :users, :persistence_token,  :string,  :null => false, :default => 0              # required
		add_column :users, :login_count,        :integer, :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
		add_column :users, :failed_login_count, :integer, :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
		add_column :users, :last_request_at,    :datetime             # optional, see Authlogic::Session::MagicColumns
		add_column :users, :current_login_at,   :datetime             # optional, see Authlogic::Session::MagicColumns
		add_column :users, :last_login_at,      :datetime             # optional, see Authlogic::Session::MagicColumns
		add_column :users, :current_login_ip,   :string               # optional, see Authlogic::Session::MagicColumns
		add_column :users, :last_login_ip,      :string               # optional, see Authlogic::Session::MagicColumns
  end

  def self.down
		remove_column :users, :crypted_password
		remove_column :users, :password_salt
		remove_column :users, :persistence_token
		remove_column :users, :login_count
		remove_column :users, :failed_login_count
		remove_column :users, :last_request_at
		remove_column :users, :current_login_at
		remove_column :users, :last_login_at
		remove_column :users, :current_login_ip
		remove_column :users, :last_login_ip
  end
end
