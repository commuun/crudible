ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start

require 'pry'
require 'dummy/config/environment'
require 'rspec/rails'

require 'crudible'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.infer_spec_type_from_file_location!
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.warnings = true
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.order = :random
  Kernel.srand config.seed

  config.before do
    Crudible.configuration = nil
    Temping.create :user do
      with_columns do |t|
        t.string :email
        t.integer :position
      end

      acts_as_list
    end
  end

  config.after do
    Temping.teardown
  end
end
