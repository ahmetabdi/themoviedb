# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'themoviedb/version'

Gem::Specification.new do |s|
  s.name        = 'themoviedb'
  s.version     = Tmdb::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Ahmet Abdi']
  s.email       = ['ahmetabdi@gmail.com']
  s.homepage    = 'https://rubygems.org/gems/themoviedb'
  s.summary     = 'A Ruby wrapper for the The Movie Database API.'
  s.description = 'Provides a simple, easy to use interface for The Movie Database API.'
  s.files = Dir['README.md', 'themoviedb.gemspec', 'lib/**/*']
  s.test_files = Dir['spec/**/*']
  s.require_paths = ['lib']

  s.add_runtime_dependency 'httparty'

  s.add_development_dependency 'vcr'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'
end
