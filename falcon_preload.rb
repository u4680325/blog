# preload.rb

# Load the entire Rails environment
require_relative "config/environment"

# Disconnect the master process from the database after preloading.
# This prevents database connection sharing issues when workers fork.
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.connection.disconnect!
end

# NOTE: The workers will automatically re-establish connections
# thanks to Rails' standard initialization hooks (Railties).
