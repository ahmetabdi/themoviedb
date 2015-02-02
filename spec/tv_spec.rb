require 'rspec'
require 'spec_helper'
require 'vcr'

describe Tmdb::TV do

  @fields = [
      :backdrop_path,
      :created_by,
      :episode_run_time,
      :first_air_date,
      :genres,
      :homepage,
      :id,
      :in_production,
      :languages,
      :last_air_date,
      :name,
      :networks,
      :number_of_episodes,
      :number_of_seasons,
      :original_name,
      :origin_country,
      :overview,
      :popularity,
      :poster_path,
      :seasons,
      :status,
      :vote_average,
      :vote_count,
      :credits,
      :external_ids
    ]

  @fields.each do |field|
    it { should respond_to field }
  end

  describe "For Chuck it should return images" do
    before(:each) do
      VCR.use_cassette 'tv/test_chuck' do
        @tv = Tmdb::TV.images(1404)
      end
    end

    it "should return backdrops for chuck" do
      @tv['backdrops'].length.should >= 1
    end

    it "should return posters for chuck" do
      @tv['posters'].length.should >= 1
    end
  end

  describe "For a TV detail" do

    before(:each) do
      VCR.use_cassette 'tv/detail' do
        @tv = Tmdb::TV.detail(1396)
      end
    end

    it "should return a id" do
      @tv['id'].should == 1396
    end

    it "should return a backdrop" do
      @tv['backdrop_path'].should == "/8STVFl9kvWtFAydXUFHIUvT47AA.jpg"
    end

    it "should return a created date" do
      @tv['created_by'].first['name'].should == "Vince Gilligan"
    end

    it "should return a run time" do
      @tv['episode_run_time'].should == [45, 47]
    end

    it "should return genres" do
      @tv['genres'].should_not == []
    end

    it "should return a first air date" do
      @tv['first_air_date'].should == "2008-01-20"
    end

    it "should return a homepage" do
      @tv['homepage'].should == "http://www.amctv.com/shows/breaking-bad"
    end

    it "should return a production state" do
      @tv['in_production'].should be_false
    end

    it "should return languages" do
      @tv['languages'].should == ["en", "de", "ro", "es", "fa"]
    end

    it "should return a last air date" do
      @tv['last_air_date'].should == "2013-09-29"
    end

    it "should return a name" do
      @tv['name'].should == "Breaking Bad"
    end

    it "should return a network" do
      @tv['networks'].first['id'].should == 174
      @tv['networks'].first['name'] == "AMC"
    end

    it "should return the number of episodes" do
      @tv['number_of_episodes'].should == 62
    end

    it "should return the number of seasons" do
      @tv['number_of_seasons'].should == 5
    end

    it "should return the original name" do
      @tv['original_name'].should == "Breaking Bad"
    end

    it "should return the origin country" do
      @tv['origin_country'].should == ["US"]
    end

    it "should return a overview" do
      @tv['overview'].should == "Breaking Bad is an American crime drama television series created and produced by Vince Gilligan. Set and produced in Albuquerque, New Mexico, Breaking Bad is the story of Walter White, a struggling high school chemistry teacher who is diagnosed with inoperable lung cancer at the beginning of the series. He turns to a life of crime, producing and selling methamphetamine, in order to secure his family's financial future before he dies, teaming with his former student, Jesse Pinkman. Heavily serialized, the series is known for positioning its characters in seemingly inextricable corners and has been labeled a contemporary western by its creator."
    end

    it "should return a popularity rating" do
      @tv['popularity'].should == 6.60821276854239
    end

    it "should return a poster" do
      @tv['poster_path'].should == "/iRDNn9EHKuBhGa77UBteazvsZa1.jpg"
    end

    it "should return seasons" do
      @tv['seasons'].should_not == []
    end

    it "should return a status" do
      @tv['status'].should == "Ended"
    end

    it "should return a vote average" do
      @tv['vote_average'].should == 8.86764705882353
    end

    it "should return a vote count" do
      @tv['vote_count'].should == 34
    end

  end

  describe "For a TV detail with appended response" do
    let(:append_fields) { %w{ credits external_ids }.join(',') }

    before(:each) do
      VCR.use_cassette 'tv/detail_with_appeded_response' do
        @tv = Tmdb::TV.detail(1396, append_to_response: append_fields)
      end
    end

    it 'should return credits' do
      @tv['credits']['cast'].size.should == 7
      @tv['credits']['cast'].first['id'].should == 17419
      @tv['credits']['crew'].size.should == 4
      @tv['credits']['crew'].first['id'].should == 5162
    end

    it 'should return external_ids' do
      @tv['external_ids']['imdb_id'].should == 'tt0903747'
    end
  end

  describe "For popular TV shows" do

    before(:each) do
      VCR.use_cassette 'tv/popular' do
        @tv = Tmdb::TV.popular
      end
    end

    it "should return an array" do
      @tv.class.should == Array
    end

    it "each show should return an id" do
      @tv.first['id'].should == 57243
    end

    it "each show should return an name" do
      @tv.first['name'].should == "Doctor Who"
    end

    it "each show should return an original name" do
      @tv.first['original_name'].should == "Doctor Who"
    end

    it "each show should return an popularity" do
      @tv.first['popularity'].should == 16.5167252220739
    end

    it "each show should return an poster_path" do
      @tv.first['poster_path'].should == "/4a94ptIdYz0JwSzo0dCNuPCcfM8.jpg"
    end

    it "each show should return an vote_average" do
      @tv.first['vote_average'].should == 7.875
    end

    it "each show should return an vote_count" do
      @tv.first['vote_count'].should == 4
    end

    it "each show should return an backdrop" do
      @tv.first['backdrop_path'].should == nil
    end

    it "each show should return an first air date" do
      @tv.first['first_air_date'].should == "2005-03-26"
    end

  end

  describe "For top rated TV shows" do

    before(:each) do
      VCR.use_cassette 'tv/top_rated' do
        @tv = Tmdb::TV.top_rated
      end
    end

    it "should return an array" do
      @tv.class.should == Array
    end

    it "each show should return an id" do
      @tv.first['id'].should == 1104
    end

    it "each show should return an name" do
      @tv.first['name'].should == "Mad Men"
    end

    it "each show should return an original name" do
      @tv.first['original_name'].should == "Mad Men"
    end

    it "each show should return an popularity" do
      @tv.first['popularity'].should == 2.15615937122719
    end

    it "each show should return an poster_path" do
      @tv.first['poster_path'].should == "/xA2nHrx2oHGPnL4ehBwPxD0ABvb.jpg"
    end

    it "each show should return an vote_average" do
      @tv.first['vote_average'].should == 9.66666666666667
    end

    it "each show should return an vote_count" do
      @tv.first['vote_count'].should == 3
    end

    it "each show should return an backdrop" do
      @tv.first['backdrop_path'].should == "/yGW0NX3I8GXPlWPdoWWyaH0AsCk.jpg"
    end

    it "each show should return an first air date" do
      @tv.first['first_air_date'].should == "2007-07-19"
    end

  end

  describe "For a TV shows images" do

    describe "For backdrops" do

      before(:each) do
        VCR.use_cassette 'tv/images' do
          @backdrop = Tmdb::TV.images(1396)['backdrops'].first
        end
      end

      it "should return a aspect ratio" do
        @backdrop['aspect_ratio'].should == 1.78
      end

      it "should return a file path" do
        @backdrop['file_path'].should == "/dRaV8HGx7Z9xmw77qSs8prp5OuI.jpg"
      end

      it "should return a height" do
        @backdrop['height'].should == 720
      end

      it "should return a iso code" do
        @backdrop['iso_639_1'].should == nil
      end

      it "should return a vote average" do
        @backdrop['vote_average'].should == 0.0
      end

      it "should return a vote count" do
        @backdrop['vote_count'].should == 0.0
      end

      it "should return a width" do
        @backdrop['width'].should == 1280
      end

    end

    describe "For posters" do

      before(:each) do
        VCR.use_cassette 'tv/images' do
          @poster = Tmdb::TV.images(1396)['posters'].first
        end
      end

      it "should return a aspect ratio" do
        @poster['aspect_ratio'].should == 1.0
      end

      it "should return a file path" do
        @poster['file_path'].should == "/lVbofIPlw3kYa8FQgHT7GtWMI2Q.jpg"
      end

      it "should return a height" do
        @poster['height'].should == 1000
      end

      it "should return a iso code" do
        @poster['iso_639_1'].should == "nl"
      end

      it "should return a vote average" do
        @poster['vote_average'].should == 5.3125
      end

      it "should return a vote count" do
        @poster['vote_count'].should == 1
      end

      it "should return a width" do
        @poster['width'].should == 1000
      end

    end

  end

  describe "For a TV shows cast" do

    before(:each) do
      VCR.use_cassette 'tv/cast' do
        @cast = Tmdb::TV.cast(1396).first
      end
    end

    it "should return a id" do
      @cast['id'].should == 17419
    end

    it "should return a name" do
      @cast['name'].should == "Bryan Cranston"
    end

    it "should return a order" do
      @cast['order'].should == 0
    end

    it "should return a profile image" do
      @cast['profile_path'].should == "/qXWgFCk4OJqmLRUBEj7cbp8dnkx.jpg"
    end

    it "should return a character name" do
      @cast['character'].should == "Walter White"
    end

    it "should return a credit id" do
      @cast['credit_id'].should == "52542282760ee313280017f9"
    end

  end

  describe "For a TV shows crew" do

    before(:each) do
      VCR.use_cassette 'tv/crew' do
        @crew = Tmdb::TV.crew(1396).first
      end
    end

    it "should return a id" do
      @crew['id'].should == 29779
    end

    it "should return a department" do
      @crew['department'].should == "Production"
    end

    it "should return a job" do
      @crew['job'].should == "Executive Producer"
    end

    it "should return a name" do
      @crew['name'].should == "Michelle MacLaren"
    end

    it "should return a profile image" do
      @crew['profile_path'].should == nil
    end

  end

  describe "For a TV shows external ids" do

    before(:each) do
      VCR.use_cassette 'tv/external_ids' do
        @external = Tmdb::TV.external_ids(1396)
      end
    end

    it "should return a id" do
      @external['id'].should == 1396
    end

    it "should return a imdb id" do
      @external['imdb_id'].should == "tt0903747"
    end

    it "should return a tvdb id" do
      @external['tvdb_id'].should == 81189
    end

    it "should return a tvrage id" do
      @external['tvrage_id'].should == 18164
    end

    it "should return a freebase id" do
      @external['freebase_id'].should == "/en/breaking_bad"
    end

    it "should return a freebase mid" do
      @external['freebase_mid'].should == "/m/03d34x8"
    end


  end

end
