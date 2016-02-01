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

  describe 'For Chuck it should return images' do
    before(:each) do
      VCR.use_cassette 'tv/test_chuck' do
        @tv = Tmdb::TV.images(1404)
      end
    end

    it 'should return backdrops for chuck' do
      expect(@tv['backdrops'].length).to be >= 1
    end

    it 'should return posters for chuck' do
      expect(@tv['posters'].length).to be >= 1
    end
  end

  describe 'For a TV detail' do
    before(:each) do
      VCR.use_cassette 'tv/detail' do
        @tv = Tmdb::TV.detail(1396)
      end
    end

    it 'should return a id' do
      expect(@tv['id']).to eq 1396
    end

    it 'should return a backdrop' do
      expect(@tv['backdrop_path']).to eq '/8STVFl9kvWtFAydXUFHIUvT47AA.jpg'
    end

    it 'should return a created date' do
      expect(@tv['created_by'].first['name']).to eq 'Vince Gilligan'
    end

    it 'should return a run time' do
      expect(@tv['episode_run_time']).to eq [45, 47]
    end

    it 'should return genres' do
      expect(@tv['genres']).not_to eq []
    end

    it 'should return a first air date' do
      expect(@tv['first_air_date']).to eq '2008-01-20'
    end

    it 'should return a homepage' do
      expect(@tv['homepage']).to eq 'http://www.amctv.com/shows/breaking-bad'
    end

    it 'should return a production state' do
      expect(@tv['in_production']).to be_falsey
    end

    it 'should return languages' do
      expect(@tv['languages']).to eq %w(en de ro es fa)
    end

    it 'should return a last air date' do
      expect(@tv['last_air_date']).to eq '2013-09-29'
    end

    it 'should return a name' do
      expect(@tv['name']).to eq 'Breaking Bad'
    end

    it 'should return a network' do
      expect(@tv['networks'].first['id']).to eq 174
      @tv['networks'].first['name'] == 'AMC'
    end

    it 'should return the number of episodes' do
      expect(@tv['number_of_episodes']).to eq 62
    end

    it 'should return the number of seasons' do
      expect(@tv['number_of_seasons']).to eq 5
    end

    it 'should return the original name' do
      expect(@tv['original_name']).to eq 'Breaking Bad'
    end

    it 'should return the origin country' do
      expect(@tv['origin_country']).to eq ['US']
    end

    it 'should return a overview' do
      expect(@tv['overview']).to eq "Breaking Bad is an American crime drama television series created and produced by Vince Gilligan. Set and produced in Albuquerque, New Mexico, Breaking Bad is the story of Walter White, a struggling high school chemistry teacher who is diagnosed with inoperable lung cancer at the beginning of the series. He turns to a life of crime, producing and selling methamphetamine, in order to secure his family's financial future before he dies, teaming with his former student, Jesse Pinkman. Heavily serialized, the series is known for positioning its characters in seemingly inextricable corners and has been labeled a contemporary western by its creator."
    end

    it 'should return a popularity rating' do
      expect(@tv['popularity']).to eq 6.60821276854239
    end

    it 'should return a poster' do
      expect(@tv['poster_path']).to eq '/iRDNn9EHKuBhGa77UBteazvsZa1.jpg'
    end

    it 'should return seasons' do
      expect(@tv['seasons']).not_to eq []
    end

    it 'should return a status' do
      expect(@tv['status']).to eq 'Ended'
    end

    it 'should return a vote average' do
      expect(@tv['vote_average']).to eq 8.86764705882353
    end

    it 'should return a vote count' do
      expect(@tv['vote_count']).to eq 34
    end
  end

  describe 'For a TV detail with appended response' do
    let(:append_fields) { %w( credits external_ids ).join(',') }

    before(:each) do
      VCR.use_cassette 'tv/detail_with_appeded_response' do
        @tv = Tmdb::TV.detail(1396, append_to_response: append_fields)
      end
    end

    it 'should return credits' do
      expect(@tv['credits']['cast'].size).to eq 7
      expect(@tv['credits']['cast'].first['id']).to eq 17_419
      expect(@tv['credits']['crew'].size).to eq 4
      expect(@tv['credits']['crew'].first['id']).to eq 5162
    end

    it 'should return external_ids' do
      expect(@tv['external_ids']['imdb_id']).to eq 'tt0903747'
    end
  end

  describe 'For popular TV shows' do
    before(:each) do
      VCR.use_cassette 'tv/popular' do
        @tv = Tmdb::TV.popular
      end
    end

    it 'should return an array' do
      expect(@tv.class).to eq Array
    end

    it 'each show should return an id' do
      expect(@tv.first.id).to eq 57_243
    end

    it 'each show should return an name' do
      expect(@tv.first.name).to eq 'Doctor Who'
    end

    it 'each show should return an original name' do
      expect(@tv.first.original_name).to eq 'Doctor Who'
    end

    it 'each show should return an popularity' do
      expect(@tv.first.popularity).to eq 16.5167252220739
    end

    it 'each show should return an poster_path' do
      expect(@tv.first.poster_path).to eq '/4a94ptIdYz0JwSzo0dCNuPCcfM8.jpg'
    end

    it 'each show should return an vote_average' do
      expect(@tv.first.vote_average).to eq 7.875
    end

    it 'each show should return an vote_count' do
      expect(@tv.first.vote_count).to eq 4
    end

    it 'each show should return an backdrop' do
      expect(@tv.first.backdrop_path).to eq nil
    end

    it 'each show should return an first air date' do
      expect(@tv.first.first_air_date).to eq '2005-03-26'
    end
  end

  describe 'For top rated TV shows' do
    before(:each) do
      VCR.use_cassette 'tv/top_rated' do
        @tv = Tmdb::TV.top_rated
      end
    end

    it 'should return an array' do
      expect(@tv.class).to eq Array
    end

    it 'each show should return an id' do
      expect(@tv.first.id).to eq 1104
    end

    it 'each show should return an name' do
      expect(@tv.first.name).to eq 'Mad Men'
    end

    it 'each show should return an original name' do
      expect(@tv.first.original_name).to eq 'Mad Men'
    end

    it 'each show should return an popularity' do
      expect(@tv.first.popularity).to eq 2.15615937122719
    end

    it 'each show should return an poster_path' do
      expect(@tv.first.poster_path).to eq '/xA2nHrx2oHGPnL4ehBwPxD0ABvb.jpg'
    end

    it 'each show should return an vote_average' do
      expect(@tv.first.vote_average).to eq 9.66666666666667
    end

    it 'each show should return an vote_count' do
      expect(@tv.first.vote_count).to eq 3
    end

    it 'each show should return an backdrop' do
      expect(@tv.first.backdrop_path).to eq '/yGW0NX3I8GXPlWPdoWWyaH0AsCk.jpg'
    end

    it 'each show should return an first air date' do
      expect(@tv.first.first_air_date).to eq '2007-07-19'
    end
  end

  describe 'For a TV shows images' do
    describe 'For backdrops' do
      before(:each) do
        VCR.use_cassette 'tv/images' do
          @backdrop = Tmdb::TV.images(1396)['backdrops'].first
        end
      end

      it 'should return a aspect ratio' do
        expect(@backdrop['aspect_ratio']).to eq 1.78
      end

      it 'should return a file path' do
        expect(@backdrop['file_path']).to eq '/dRaV8HGx7Z9xmw77qSs8prp5OuI.jpg'
      end

      it 'should return a height' do
        expect(@backdrop['height']).to eq 720
      end

      it 'should return a iso code' do
        expect(@backdrop['iso_639_1']).to eq nil
      end

      it 'should return a vote average' do
        expect(@backdrop['vote_average']).to eq 0.0
      end

      it 'should return a vote count' do
        expect(@backdrop['vote_count']).to eq 0.0
      end

      it 'should return a width' do
        expect(@backdrop['width']).to eq 1280
      end
    end

    describe 'For posters' do
      before(:each) do
        VCR.use_cassette 'tv/images' do
          @poster = Tmdb::TV.images(1396)['posters'].first
        end
      end

      it 'should return a aspect ratio' do
        expect(@poster['aspect_ratio']).to eq 1.0
      end

      it 'should return a file path' do
        expect(@poster['file_path']).to eq '/lVbofIPlw3kYa8FQgHT7GtWMI2Q.jpg'
      end

      it 'should return a height' do
        expect(@poster['height']).to eq 1000
      end

      it 'should return a iso code' do
        expect(@poster['iso_639_1']).to eq 'nl'
      end

      it 'should return a vote average' do
        expect(@poster['vote_average']).to eq 5.3125
      end

      it 'should return a vote count' do
        expect(@poster['vote_count']).to eq 1
      end

      it 'should return a width' do
        expect(@poster['width']).to eq 1000
      end
    end
  end

  describe 'For a TV shows cast' do
    before(:each) do
      VCR.use_cassette 'tv/cast' do
        @cast = Tmdb::TV.cast(1396).first
      end
    end

    it 'should return a id' do
      expect(@cast['id']).to eq 17_419
    end

    it 'should return a name' do
      expect(@cast['name']).to eq 'Bryan Cranston'
    end

    it 'should return a order' do
      expect(@cast['order']).to eq 0
    end

    it 'should return a profile image' do
      expect(@cast['profile_path']).to eq '/qXWgFCk4OJqmLRUBEj7cbp8dnkx.jpg'
    end

    it 'should return a character name' do
      expect(@cast['character']).to eq 'Walter White'
    end

    it 'should return a credit id' do
      expect(@cast['credit_id']).to eq '52542282760ee313280017f9'
    end
  end

  describe 'For a TV shows crew' do
    before(:each) do
      VCR.use_cassette 'tv/crew' do
        @crew = Tmdb::TV.crew(1396).first
      end
    end

    it 'should return a id' do
      expect(@crew['id']).to eq 29_779
    end

    it 'should return a department' do
      expect(@crew['department']).to eq 'Production'
    end

    it 'should return a job' do
      expect(@crew['job']).to eq 'Executive Producer'
    end

    it 'should return a name' do
      expect(@crew['name']).to eq 'Michelle MacLaren'
    end

    it 'should return a profile image' do
      expect(@crew['profile_path']).to eq nil
    end
  end

  describe 'For a TV shows external ids' do
    before(:each) do
      VCR.use_cassette 'tv/external_ids' do
        @external = Tmdb::TV.external_ids(1396)
      end
    end

    it 'should return a id' do
      expect(@external['id']).to eq 1396
    end

    it 'should return a imdb id' do
      expect(@external['imdb_id']).to eq 'tt0903747'
    end

    it 'should return a tvdb id' do
      expect(@external['tvdb_id']).to eq 81_189
    end

    it 'should return a tvrage id' do
      expect(@external['tvrage_id']).to eq 18_164
    end

    it 'should return a freebase id' do
      expect(@external['freebase_id']).to eq '/en/breaking_bad'
    end

    it 'should return a freebase mid' do
      expect(@external['freebase_mid']).to eq '/m/03d34x8'
    end
  end
end
