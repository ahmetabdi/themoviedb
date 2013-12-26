require 'rspec'
require 'spec_helper'
require 'vcr'

describe Tmdb::Find do

  describe "For a search" do
    before(:each) do
      @find = Tmdb::Find
    end

    it "should return results for imdb_id" do
      VCR.use_cassette 'find/search_imdb' do
        find = @find.imdb_id("tt1375666")
        find['movie_results'].should be_true
        find['person_results'].should be_true
        find['tv_results'].should be_true
      end
    end

    it "should return results for tvdb_id" do
      VCR.use_cassette 'find/search_tvdb' do
        find = @find.tvdb_id("81189")
        find['tv_results'].first['name'].should == 'Breaking Bad'
        find['tv_results'].should be_true
      end
    end

  end

end
