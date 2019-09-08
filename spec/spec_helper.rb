ENV['RAILS_ENV'] ||= 'test'

require 'pry'
require 'dummy/config/environment'
require 'rspec/rails'

require 'crudible'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus

  config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.order = :random

  Kernel.srand config.seed
end
