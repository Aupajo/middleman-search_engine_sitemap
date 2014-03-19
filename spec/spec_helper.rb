require 'rspec'

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

# Include support files
support_files_pattern = File.expand_path('../support/**/*.rb', __FILE__)
Dir.glob(support_files_pattern).each { |f| require f }

RSpec.configure do |config|
  # Will be the default in RSpec 3
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.include MiddlemanServerHelpers, :feature
end