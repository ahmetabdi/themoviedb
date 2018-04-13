# encoding: utf-8
require 'rspec'
require 'spec_helper'
require 'vcr'

describe Tmdb::Keyword do
  @fields = [:id, :name]

  @fields.each do |field|
    it { should respond_to field }
  end

  describe 'For a keyword detail' do
    before(:each) do
      VCR.use_cassette 'keyword/detail' do
        @keyword = Tmdb::Keyword.detail(818)
      end
    end

    it 'should return a id' do
      expect(@keyword['id']).to eq 818
    end

    it 'should return a name' do
      expect(@keyword['name']).to eq 'based on novel'
    end
  end

  describe 'For a keyword movies' do
    before(:each) do
      VCR.use_cassette 'keyword/movies_for_id' do
        @movies = Tmdb::Keyword.movies(818)
        @movie  = @movies.first
      end
    end

    it 'should give back multiple movies' do
      expect(@movies.count).to be > 1
    end

    it 'should have a id' do
      expect(@movie.id).to eq(341_174)
    end

    it 'should have a title' do
      expect(@movie.title).to eq('Fifty Shades Darker')
    end

    it 'should have a original title' do
      expect(@movie.original_title).to eq('Fifty Shades Darker')
    end

    it 'should have a poster' do
      expect(@movie.poster_path).to eq('/7SMCz5724COOYDhY0mj0NfcJqxH.jpg')
    end

    it 'should have a popularity rating' do
      expect(@movie.popularity).to eq(208.414524)
    end

    it 'should show whether it is an adult movie' do
      expect(@movie.adult).to eq(false)
    end

    it 'should have a release date' do
      expect(@movie.release_date).to eq('2017-02-08')
    end
  end
end
