require 'rubygems'
require 'httparty'

["api","search","resource", "configuration"].each do |inc|
  require File.join(File.dirname(__FILE__), "themoviedb", inc)
end

["movie", "collection", "people", "company"].each do |inc|
  require File.join(File.dirname(__FILE__), "themoviedb", inc)
end

module Tmdb
  VERSION = "0.0.2"
end