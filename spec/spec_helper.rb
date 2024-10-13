# frozen_string_literal: true

require 'themoviedb'
require 'vcr'

$VALID_API_KEY = '8a221fc31fcdf12a8af827465574ffc9'
Tmdb::Api.key($VALID_API_KEY)

VCR.configure do |c|
  # the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'
  # your HTTP request service. You can also use fakeweb, webmock, and more
  c.hook_into :webmock
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
