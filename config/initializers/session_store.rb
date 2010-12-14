# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dicty11_session',
  :secret      => '1db9e5a6fafec17439cff66f033710d45279e96fe978abc80bfa9ba4d594ac49031fc653fef6e8f6928fe4c061518dad43c8e3aee1ff8632761096a32746a112'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
