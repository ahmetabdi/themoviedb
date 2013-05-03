# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "themoviedb"

Gem::Specification.new do |s|
  s.name        = "themoviedb"
  s.version     = Tmdb::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ahmet Abdi"]
  s.email       = ["ahmetabdi@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/themoviedb"
  s.summary     = %q{A Ruby wrapper for the The Movie Database API.}
  s.description = %q{Provides a simple, easy to use interface for the Movie Database API.}
  s.rubyforge_project = "themoviedb"
  s.files         = [
                      "themoviedb.gemspec",
                      "lib/themoviedb.rb",
                      "lib/themoviedb/api.rb",
                      "lib/themoviedb/collection.rb",
                      "lib/themoviedb/company.rb",
                      "lib/themoviedb/configuration.rb",
                      "lib/themoviedb/genre.rb",
                      "lib/themoviedb/movie.rb",
                      "lib/themoviedb/people.rb",
                      "lib/themoviedb/resource.rb",
                      "lib/themoviedb/search.rb",
                      "test/movie_test.rb"
                    ]
  s.test_files    = [
                      "test/movie_test.rb"
                    ]
  s.require_paths = ["lib"]
  s.add_dependency('httparty')
end