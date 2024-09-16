# encoding: utf-8
require 'rspec'
require 'spec_helper'
require 'vcr'

describe Tmdb::Movie do
  @fields = [:id, :adult, :backdrop_path, :belongs_to_collection,
             :budget, :genres, :homepage, :imdb_id, :original_language, :original_title,
             :overview, :popularity, :poster_path, :production_companies,
             :production_countries, :release_date, :revenue, :runtime,
             :spoken_languages, :status, :tagline, :title, :vote_average,
             :vote_count, :alternative_titles, :credits, :images, :keywords,
             :releases, :trailers, :translations, :reviews, :lists]

  @fields.each do |field|
    it { should respond_to field }
  end

  describe 'For a movie' do
    before(:each) do
      @movie = Tmdb::Movie
    end

    it 'should return the latest movies' do
      VCR.use_cassette 'movie/return_latest_movie' do
        expect(@movie.latest).to be_truthy
      end
    end

    it 'should return the upcoming movies' do
      VCR.use_cassette 'movie/return_upcoming_movie' do
        expect(@movie.upcoming).to be_truthy
      end
    end

    it 'should show movies that are now playing' do
      VCR.use_cassette 'movie/now_playing' do
        expect(@movie.now_playing).to be_truthy
      end
    end

    it 'should return popular movies' do
      VCR.use_cassette 'movie/popular' do
        expect(@movie.popular).to be_truthy
      end
    end

    it 'should return top rated movies' do
      VCR.use_cassette 'movie/top_rated' do
        expect(@movie.top_rated).to be_truthy
      end
    end

    it 'should return alternative titles for an ID' do
      VCR.use_cassette 'movie/alternative_titles_for_id' do
        expect(@movie.alternative_titles(5)).to be_truthy
      end
    end

    it 'should return cast information for an ID' do
      VCR.use_cassette 'movie/cast_information_for_id' do
        expect(@movie.casts(5)).to be_truthy
      end
    end

    it 'should return crew for an ID' do
      VCR.use_cassette 'movie/crew_for_id' do
        expect(@movie.crew(5)).to be_truthy
      end
    end

    it 'should return keywords for an ID' do
      VCR.use_cassette 'movie/keywords_for_id' do
        expect(@movie.keywords(5)).to be_truthy
      end
    end

    it 'should return releases for an ID' do
      VCR.use_cassette 'movie/releases_for_id' do
        expect(@movie.releases(5)).to be_truthy
      end
    end

    it 'should return trailers for an ID' do
      VCR.use_cassette 'movie/trailers_for_id' do
        expect(@movie.trailers(5)).to be_truthy
      end
    end

    it 'should return translations for an ID' do
      VCR.use_cassette 'movie/translations_for_id' do
        expect(@movie.translations(5)).to be_truthy
      end
    end

    it 'should return similar_movies for an ID' do
      VCR.use_cassette 'movie/similar_for_id' do
        expect(@movie.similar_movies(5)).to be_truthy
      end
    end

    it 'should return the list the movie belongs to' do
      VCR.use_cassette 'movie/movie_belongs_for_id' do
        expect(@movie.lists(5)).to be_truthy
      end
    end

    it 'should return the changes made' do
      VCR.use_cassette 'movie/changes_made' do
        expect(@movie.changes(5)).to be_truthy
      end
    end

    it 'should return credits for an ID' do
      VCR.use_cassette 'movie/credits_for_id' do
        expect(@movie.credits(5)).to be_truthy
      end
    end
  end

  describe 'For a movie detail' do
    before(:each) do
      VCR.use_cassette 'movie/detail' do
        @movie = Tmdb::Movie.detail(22_855)
      end
    end

    it 'should return a id' do
      expect(@movie['id']).to eq 22_855
    end

    it 'should return a adult' do
      expect(@movie['adult']).to eq false
    end

    it 'should return a backdrop_path' do
      expect(@movie['backdrop_path']).to eq '/aMyEMGuW2NV3A0whuEM7VKp6M73.jpg'
    end

    it 'should return a belongs_to_collection' do
      expect(@movie['belongs_to_collection']['name']).to eq 'Superman / Batman (Animated) Collection'
    end

    it 'should return a budget' do
      expect(@movie['budget']).to eq 0
    end

    it 'should return genres' do
      expect(@movie['genres']).not_to eq []
    end

    it 'should return homepage' do
      expect(@movie['homepage']).to eq 'https://www.warnerbros.com/supermanbatman-public-enemies'
    end

    it 'should return a imdb_id' do
      expect(@movie['imdb_id']).to eq 'tt1398941'
    end

    it 'should return an original_language' do
      expect(@movie['original_language']).to eq 'en'
    end

    it 'should return a original_title' do
      expect(@movie['original_title']).to eq 'Superman/Batman: Public Enemies'
    end

    it 'should return a overview' do
      expect(@movie['overview']).to eq "United States President Lex Luthor uses the oncoming trajectory of a Kryptonite meteor to frame Superman and declare a $1 billion bounty on the heads of the Man of Steel and his ‘partner in crime’, Batman. Heroes and villains alike launch a relentless pursuit of Superman and Batman, who must unite—and recruit help—to try and stave off the action-packed onslaught, stop the meteor Luthors plot."
    end

    it 'should return popularity' do
      expect(@movie['popularity']).to eq 10.200109
    end

    it 'should return poster_path' do
      expect(@movie['poster_path']).to eq '/bJBZxzFHfTAOtBg8fOCCaBmh4hF.jpg'
    end

    it 'should return production_companies' do
      expect(@movie['production_companies']).not_to eq []
    end

    it 'should return production_countries' do
      expect(@movie['production_countries']).not_to eq []
    end

    it 'should return release_date' do
      expect(@movie['release_date']).to eq '2009-09-29'
    end

    it 'should return revenue' do
      expect(@movie['revenue']).to eq 0
    end

    it 'should return a runtime' do
      expect(@movie['runtime']).to eq 67
    end

    it 'should return spoken_languages' do
      expect(@movie['spoken_languages'].first['name']).to eq 'English'
    end

    it 'should return status' do
      expect(@movie['status']).to eq 'Released'
    end

    it 'should return vote_average' do
      expect(@movie['vote_average']).to eq 6.8
    end

    it 'should return vote_count' do
      expect(@movie['vote_count']).to eq 199
    end
  end

  describe 'For a movie search' do
    before(:each) do
      VCR.use_cassette 'movie/search' do
        @movies = Tmdb::Movie.search("House", year: 1977)
      end
    end

    it 'should return movies from the year specified' do
      # House (1977) doesn't appear in the first page unless year is specified
      expect(@movies).to include(an_object_having_attributes(id: 25623))
    end
  end

  describe 'For a movie detail with appended response' do
    let(:append_fields) do
      %w( alternative_titles credits images keywords releases
          trailers translations reviews lists changes ).join(',')
    end
    before(:each) do
      VCR.use_cassette 'movie/detail_with_appended_response' do
        @movie = Tmdb::Movie.detail(22_855, append_to_response: append_fields)
      end
    end

    it 'should return alternative_titles' do
      expect(@movie['alternative_titles']['titles'].size).to eq 4
      expect(@movie['alternative_titles']['titles'].first['title']).to eq 'Superman und Batman Public Enemies'
    end

    it 'should return credits' do
      expect(@movie['credits']['cast'].size).to eq 20
      expect(@movie['credits']['cast'].first['id']).to eq 34_947
      expect(@movie['credits']['crew'].size).to eq 3
      expect(@movie['credits']['crew'].first['id']).to eq 90_367
    end

    it 'should return images' do
      expect(@movie['images']['backdrops'].size).to eq 6
      expect(@movie['images']['backdrops'].first['file_path']).to eq '/mXuqM7ksHW1AJ30AInwJvJTAwut.jpg'
      expect(@movie['images']['posters'].size).to eq 9
      expect(@movie['images']['posters'].first['file_path']).to eq '/7eaHkUKAzfstt6XQCiXyuKiZUAw.jpg'
    end

    it 'should return keywords' do
      expect(@movie['keywords']['keywords'].size).to eq 2
      expect(@movie['keywords']['keywords'].first['id']).to eq 9715
    end

    it 'should return releases' do
      expect(@movie['releases']['countries'].size).to eq 1
      expect(@movie['releases']['countries'].first['release_date']).to eq '2009-09-29'
    end

    it 'should return trailers' do
      expect(@movie['trailers']['quicktime']).to eq []
      expect(@movie['trailers']['youtube'].size).to eq 1
      expect(@movie['trailers']['youtube'].first['name']).to eq 'Official Preview Trailer'
    end

    it 'should return translations' do
      expect(@movie['translations']['translations'].size).to eq 13
      expect(@movie['translations']['translations'].first['name']).to eq 'English'
    end

    it 'should return reviews' do
      expect(@movie['reviews']['results']).to eq []
    end

    it 'should return lists' do
      expect(@movie['lists']['results'].size).to eq 4
      expect(@movie['lists']['results'].first['id']).to eq '51d6b52219c295172912ff1e'
    end

    it 'should return changes' do
      expect(@movie['changes']['changes']).to eq []
    end
  end

  describe 'For a movies images' do
    before(:each) do
      VCR.use_cassette 'movie/images' do
        @movie = Tmdb::Movie.images(22_855)
      end
    end

    it 'should return backdrops' do
      @movie['backdrops'].length == 4
    end

    it 'should return posters' do
      expect(@movie['posters']).to be_truthy
    end
  end

  describe 'For other languages' do
    before(:each) do
      Tmdb::Api.language('de')
      VCR.use_cassette 'movie/language_german' do
        @movie = Tmdb::Movie.detail(562)
      end
      Tmdb::Api.language(nil)
    end

    it 'should return the german name' do
      expect(@movie['title']).to eq 'Stirb Langsam'
    end

    it 'should return the german description' do
      expect(@movie['overview']).to eq "Eigentlich möchte der New Yorker Polizist John McClane dieses Weihnachten nur seine Noch-Ehefrau Holly, welche in Los Angeles in einer großen, erfolgreichen Firma Karriere gemacht hat, besuchen und das Fest mit den beiden gemeinsamen Kinder verbringen. Als die Feierlichkeiten im Nakatomi Plaza beginnen sollen, stürmt eine Gruppe von Terroristen das Hochhaus und nur John McClane schafft es ihnen zu entwischen. Lediglich bewaffnet mit ein paar Zigaretten und einem Walkie-Talkie, wodurch er den Funk der Geiselnehmer mithören kann, und mit Waffen, welche die Terroristen gelegentlich so rumliegen lassen, muss John nun nicht nur sein eigenes Leben retten, sondern möglichst auch das aller anderen Beteiligten. Und so beschließt er, die äußerst brutale Truppe auszumerzen und sich einen Terroristen nach dem anderen vorzuknöpfen. Während draußen dann schon die Polizei und das FBI stümperhaft versucht, das Gebäude zu stürmen, kämpft McClane ohne Schuhe gegen die 12 Aggressoren..."
    end
  end
end
