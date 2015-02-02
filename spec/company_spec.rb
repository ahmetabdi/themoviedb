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

  describe "For a company detail" do

    before(:each) do
      VCR.use_cassette 'company/detail' do
        @company = Tmdb::Company.detail(5)
      end
    end

    it "should return a id" do
      @company['id'].should eq(5)
    end

    it "should have a description" do
      @company['description'].should eq("Columbia Pictures Industries, Inc. (CPII) is an American film production and distribution company. Columbia Pictures now forms part of the Columbia TriStar Motion Picture Group, owned by Sony Pictures Entertainment, a subsidiary of the Japanese conglomerate Sony. It is one of the leading film companies in the world, a member of the so-called Big Six. It was one of the so-called Little Three among the eight major film studios of Hollywood's Golden Age.")
    end

    it "should have a homepage" do
      @company['homepage'].should eq("http://www.sonypictures.com/")
    end

    it "should have logo" do
      @company['logo_path'].should eq("/mjUSfXXUhMiLAA1Zq1TfStNSoLR.png")
    end

    it "should have a name" do
      @company['name'].should eq("Columbia Pictures")
    end

    it "could have a parent company" do
      @company['parent_company']["name"].should eq("Sony Pictures Entertainment")
    end

  end

  describe "For a company movies" do
    before(:each) do
      VCR.use_cassette 'company/movies' do
        @movies = Tmdb::Company.movies(5)
        @movie  = @movies.first
      end
    end

    it "should give back multiple movies" do
      @movies.count.should > 1
    end

    it "should have a id" do
      @movie["id"].should eq(97020)
    end

    it "should have a title" do
      @movie["title"].should eq("RoboCop")
    end

    it "should have a original title" do
      @movie["original_title"].should eq("RoboCop")
    end

    it "should have a poster" do
      @movie["poster_path"].should eq("/xxLhczZMiJt1iRdhfkVkuMu87si.jpg")
    end

    it "should have a popularity rating" do
      @movie["popularity"].should eq(3.13451193740971)
    end

    it "should show whether it is an adult movie" do
      @movie["adult"].should eq(false)
    end

    it "should have a release date" do
      @movie["release_date"].should eq("2014-02-07")
    end

  end

end