# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails_space_session',
  :secret      => '209174db584fdd29dc51a39279774a3a27fe3c68e3022d832fedd22b1b234bd2b5894fe45cf97f61bdede1fe100294709b5d2d7ea72697c1d1b502f003a7653c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
