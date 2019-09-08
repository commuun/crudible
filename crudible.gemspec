# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'crudible/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'crudible'
  spec.version     = Crudible::VERSION
  spec.authors     = ['Peter Duijnstee']
  spec.email       = ['peter@commuun.nl']
  spec.homepage    = 'https://github.com/commuun/crudible'
  spec.summary     = 'Lightweight default CRUD actions for your controllers.'
  spec.description = 'Add CRUD actions to your controllers'
  spec.license     = 'MIT'

  spec.files = Dir[
    '{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md'
  ]

  spec.add_dependency 'rails', '>= 4.0.0'
end
