require 'rspec'
require 'spec_helper'
require 'vcr'

describe Tmdb::Company do
  @fields = [
    :description,
    :headquarters,
    :homepage,
    :id,
    :logo_path,
    :name,
    :parent_company
  ]

  @fields.each do |field|
    it { should respond_to field }
  end

  describe 'For a company detail' do
    before(:each) do
      VCR.use_cassette 'company/detail' do
        @company = Tmdb::Company.detail(5)
      end
    end

    it 'should return a id' do
      expect(@company['id']).to eq(5)
    end

    it 'should have a description' do
      expect(@company['description']).to eq("Columbia Pictures Industries, Inc. (CPII) is an American film production and distribution company. Columbia Pictures now forms part of the Columbia TriStar Motion Picture Group, owned by Sony Pictures Entertainment, a subsidiary of the Japanese conglomerate Sony. It is one of the leading film companies in the world, a member of the so-called Big Six. It was one of the so-called Little Three among the eight major film studios of Hollywood's Golden Age.")
    end

    it 'should have a homepage' do
      expect(@company['homepage']).to eq('http://www.sonypictures.com/')
    end

    it 'should have logo' do
      expect(@company['logo_path']).to eq('/mjUSfXXUhMiLAA1Zq1TfStNSoLR.png')
    end

    it 'should have a name' do
      expect(@company['name']).to eq('Columbia Pictures')
    end

    it 'could have a parent company' do
      expect(@company['parent_company']['name']).to eq('Sony Pictures Entertainment')
    end
  end

  describe 'For a company movies' do
    before(:each) do
      VCR.use_cassette 'company/movies' do
        @movies = Tmdb::Company.movies(5)
        @movie  = @movies.first
      end
    end

    it 'should give back multiple movies' do
      expect(@movies.count).to be > 1
    end

    it 'should have a id' do
      expect(@movie.id).to eq(97_020)
    end

    it 'should have a title' do
      expect(@movie.title).to eq('RoboCop')
    end

    it 'should have a original title' do
      expect(@movie.original_title).to eq('RoboCop')
    end

    it 'should have a poster' do
      expect(@movie.poster_path).to eq('/xxLhczZMiJt1iRdhfkVkuMu87si.jpg')
    end

    it 'should have a popularity rating' do
      expect(@movie.popularity).to eq(3.13451193740971)
    end

    it 'should show whether it is an adult movie' do
      expect(@movie.adult).to eq(false)
    end

    it 'should have a release date' do
      expect(@movie.release_date).to eq('2014-02-07')
    end
  end
end
