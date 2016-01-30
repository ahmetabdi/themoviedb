require 'rspec'
require 'spec_helper'
require 'vcr'

describe Tmdb::Find do
  describe 'For a search' do
    before(:each) do
      @find = Tmdb::Find
    end

    it 'should return results for imdb_id' do
      VCR.use_cassette 'find/search_imdb' do
        find = @find.imdb_id('tt1375666')
        expect(find['movie_results']).to be_truthy
        expect(find['person_results']).to be_truthy
        expect(find['tv_results']).to be_truthy
      end
    end

    it 'should return results for tvdb_id' do
      VCR.use_cassette 'find/search_tvdb' do
        find = @find.tvdb_id('81189')
        expect(find['tv_results'].first['name']).to eq 'Breaking Bad'
        expect(find['tv_results']).to be_truthy
      end
    end
  end
end
