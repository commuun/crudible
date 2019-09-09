rails_versions = %w[
  5.1
  5.2
  6.0
]

rails_versions.each do |version|
  appraise "rails_#{version}" do
    gem 'railties', "~> #{version}.0"
  end
end
