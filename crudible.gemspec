# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'crudible/version'

Gem::Specification.new do |spec|
  spec.authors          = ['Peter Duijnstee']
  spec.description      = 'Add CRUD actions to your controllers'
  spec.email            = ['info@commuun.nl']
  spec.extra_rdoc_files = %w[LICENSE README.md]
  spec.files            = `git ls-files`.split("\n")
  spec.homepage         = 'https://github.com/commuun/crudible'
  spec.license          = 'MIT'
  spec.name             = 'crudible'
  spec.require_paths    = ['lib']
  spec.summary          = 'Lightweight CRUD actions for your controllers.'
  spec.test_files       = `git ls-files -- {spec}/*`.split("\n")
  spec.version          = Crudible::VERSION

  spec.add_dependency 'rails', '>= 4.0.0'
end
