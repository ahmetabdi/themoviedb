# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "themoviedb/version"

Gem::Specification.new do |s|
  s.name        = "themoviedb"
  s.version     = Tmdb::VERSION
  s.authors     = ["Ahmet Abdi"]
  s.email       = ["ahmetabdi@gmail.com"]

  s.homepage    = "http://rubygems.org/gems/themoviedb"
  s.summary     = %q{A Ruby wrapper for the The Movie Database API.}
  s.description = %q{Provides a simple, easy to use interface for the Movie Database API.}

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency 'rspec', '~> 3.3.0'
  s.add_development_dependency 'vcr', '~> 2.9.3'
  s.add_development_dependency 'webmock', '~> 1.21.0'

  s.add_runtime_dependency 'representable'
  s.add_runtime_dependency 'multi_json'
  s.add_runtime_dependency 'rest-client'
  s.add_runtime_dependency 'require_all'
end
