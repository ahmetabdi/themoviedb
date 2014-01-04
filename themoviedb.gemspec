# -*- encoding: utf-8 -*-
require File.expand_path("../lib/themoviedb/version", __FILE__)

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
                      "lib/themoviedb/season.rb",
                      "lib/themoviedb/episode.rb",
                      "lib/themoviedb/tv.rb",
                      "lib/themoviedb/find.rb",
                      "lib/themoviedb/version.rb"
                    ]
  s.test_files    = [
                      "spec/movie_spec.rb",
                      "spec/tv_spec.rb",
                      "spec/company_spec.rb",
                      "spec/find_spec.rb"
                    ]
  s.require_paths = ["lib"]
  s.add_dependency('httparty', '~> 0')
end
