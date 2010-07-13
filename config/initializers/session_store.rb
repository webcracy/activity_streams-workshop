# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_asws_session',
  :secret      => 'cfef9b341c114f9cc6fd18a612b6126ef3921886bffcb26c0c94b019151a9b209c0de505b134cdc43d385a1c50849003949e2579a01f580c4966044849cd2aec'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
