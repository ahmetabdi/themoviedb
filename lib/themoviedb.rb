require 'rubygems'
require 'httparty'

%w(api search resource configuration).each do |inc|
  require File.join(File.dirname(__FILE__), 'themoviedb', inc)
end

%w(movie tv season episode collection person company genre find job keyword).each do |inc|
  require File.join(File.dirname(__FILE__), 'themoviedb', inc)
end
