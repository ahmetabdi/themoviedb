#encoding: utf-8
require 'rspec'
require 'spec_helper'
require 'vcr'

describe Tmdb::Movie do

  @fields = [:id,:adult,:backdrop_path,:belongs_to_collection,
             :budget,:genres,:homepage,:imdb_id,:original_title,
             :overview,:popularity,:poster_path,:production_companies,
             :production_countries,:release_date,:revenue,:runtime,
             :spoken_languages,:status,:tagline,:title,:vote_average,
             :vote_count,:alternative_titles,:credits,:images,:keywords,
             :releases,:trailers,:translations,:reviews,:lists]

  @fields.each do |field|
    it { should respond_to field }
  end

  describe "For a movie" do
    before(:each) do
      @movie = Tmdb::Movie
    end

    it "should return the latest movies" do
      VCR.use_cassette 'movie/return_latest_movie' do
        @movie.latest.should be_true
      end
    end

    it "should return the upcoming movies" do
      VCR.use_cassette 'movie/return_upcoming_movie' do
        @movie.upcoming.should be_true
      end
    end

    it "should show movies that are now playing" do
      VCR.use_cassette 'movie/now_playing' do
        @movie.now_playing.should be_true
      end
    end

    it "should return popular movies" do
      VCR.use_cassette 'movie/popular' do
        @movie.popular.should be_true
      end
    end

    it "should return top rated movies" do
      VCR.use_cassette 'movie/top_rated' do
        @movie.top_rated.should be_true
      end
    end

    it "should return alternative titles for an ID" do
      VCR.use_cassette 'movie/alternative_titles_for_id' do
        @movie.alternative_titles(5).should be_true
      end
    end

    it "should return cast information for an ID" do
      VCR.use_cassette 'movie/cast_information_for_id' do
        @movie.casts(5).should be_true
      end
    end

    it "should return crew for an ID" do
      VCR.use_cassette 'movie/crew_for_id' do
        @movie.crew(5).should be_true
      end
    end

    it "should return keywords for an ID" do
      VCR.use_cassette 'movie/keywords_for_id' do
        @movie.keywords(5).should be_true
      end
    end

    it "should return releases for an ID" do
      VCR.use_cassette 'movie/releases_for_id' do
        @movie.releases(5).should be_true
      end
    end

    it "should return trailers for an ID" do
      VCR.use_cassette 'movie/trailers_for_id' do
        @movie.trailers(5).should be_true
      end
    end

    it "should return translations for an ID" do
      VCR.use_cassette 'movie/translations_for_id' do
        @movie.translations(5).should be_true
      end
    end

    it "should return similar_movies for an ID" do
      VCR.use_cassette 'movie/similar_for_id' do
        @movie.similar_movies(5).should be_true
      end
    end

    it "should return the list the movie belongs to" do
      VCR.use_cassette 'movie/movie_belongs_for_id' do
        @movie.lists(5).should be_true
      end
    end

    it "should return the changes made" do
      VCR.use_cassette 'movie/changes_made' do
        @movie.changes(5).should be_true
      end
    end

    it "should return credits for an ID" do
      VCR.use_cassette 'movie/credits_for_id' do
        @movie.credits(5).should be_true
      end
    end
  end

  describe "For a movie detail" do

    before(:each) do
      VCR.use_cassette 'movie/detail' do
        @movie = Tmdb::Movie.detail(22855)
      end
    end

    it "should return a id" do
      @movie['id'].should == 22855
    end

    it "should return a adult" do
      @movie['adult'].should == false
    end

    it "should return a backdrop_path" do
      @movie['backdrop_path'].should == "/mXuqM7ksHW1AJ30AInwJvJTAwut.jpg"
    end

    it "should return a belongs_to_collection" do
      @movie['belongs_to_collection']['name'].should == "DC Universe Animated Original Movies"
    end

    it "should return a budget" do
      @movie['budget'].should == 0
    end

    it "should return genres" do
      @movie['genres'].should_not == []
    end

    it "should return homepage" do
      @movie['homepage'].should == "http://www.warnervideo.com/supermanbatmandvd/"
    end

    it "should return a imdb_id" do
      @movie['imdb_id'].should == "tt1398941"
    end

    it "should return a original_title" do
      @movie['original_title'].should == "Superman/Batman: Public Enemies"
    end

    it "should return a overview" do
      @movie['overview'].should == "United States President Lex Luthor uses the oncoming trajectory of a Kryptonite meteor to frame Superman and declare a $1 billion bounty on the heads of the Man of Steel and his ‘partner in crime’, Batman. Heroes and villains alike launch a relentless pursuit of Superman and Batman, who must unite—and recruit help—to try and stave off the action-packed onslaught, stop the meteor Luthors plot."
    end

    it "should return popularity" do
      @movie['popularity'].should == 1.15974723131612
    end

    it "should return poster_path" do
      @movie['poster_path'].should == "/7eaHkUKAzfstt6XQCiXyuKiZUAw.jpg"
    end

    it "should return production_companies" do
      @movie['production_companies'].should_not == []
    end

    it "should return production_countries" do
      @movie['production_countries'].should_not == []
    end

    it "should return release_date" do
      @movie['release_date'].should == "2009-09-29"
    end

    it "should return revenue" do
      @movie['revenue'].should == 0
    end

    it "should return a runtime" do
      @movie['runtime'].should == 67
    end

    it "should return spoken_languages" do
      @movie['spoken_languages'].first['name'].should == "English"
    end

    it "should return status" do
      @movie['status'].should == "Released"
    end

    it "should return vote_average" do
      @movie['vote_average'].should == 7.4
    end

    it "should return vote_count" do
      @movie['vote_count'].should == 23
    end
  end

  describe 'For a movie detail with appended response' do
    let(:append_fields) { %w{ alternative_titles credits images keywords releases
                            trailers translations reviews lists changes }.join(',') }
    before(:each) do
      VCR.use_cassette 'movie/detail_with_appended_response' do
        @movie = Tmdb::Movie.detail(22855, append_to_response: append_fields)
      end
    end

    it 'should return alternative_titles' do
      @movie['alternative_titles']['titles'].size.should == 4
      @movie['alternative_titles']['titles'].first['title'].should == 'Superman und Batman Public Enemies'
    end

    it 'should return credits' do
      @movie['credits']['cast'].size.should == 20
      @movie['credits']['cast'].first['id'].should == 34947
      @movie['credits']['crew'].size.should == 3
      @movie['credits']['crew'].first['id'].should == 90367
    end

    it 'should return images' do
      @movie['images']['backdrops'].size.should == 6
      @movie['images']['backdrops'].first['file_path'].should == '/mXuqM7ksHW1AJ30AInwJvJTAwut.jpg'
      @movie['images']['posters'].size.should == 9
      @movie['images']['posters'].first['file_path'].should == '/7eaHkUKAzfstt6XQCiXyuKiZUAw.jpg'
    end

    it 'should return keywords' do
      @movie['keywords']['keywords'].size.should == 2
      @movie['keywords']['keywords'].first['id'].should == 9715
    end

    it 'should return releases' do
      @movie['releases']['countries'].size.should == 1
      @movie['releases']['countries'].first['release_date'].should == '2009-09-29'
    end

    it 'should return trailers' do
      @movie['trailers']['quicktime'].should == []
      @movie['trailers']['youtube'].size.should == 1
      @movie['trailers']['youtube'].first['name'].should == 'Official Preview Trailer'
    end

    it 'should return translations' do
      @movie['translations']['translations'].size.should == 13
      @movie['translations']['translations'].first['name'].should == 'English'
    end

    it 'should return reviews' do
      @movie['reviews']['results'].should == []
    end

    it 'should return lists' do
      @movie['lists']['results'].size.should == 4
      @movie['lists']['results'].first['id'].should == '51d6b52219c295172912ff1e'
    end

    it 'should return changes' do
      @movie['changes']['changes'].should == []
    end
  end

  describe "For a movies images" do

    before(:each) do
      VCR.use_cassette 'movie/images' do
        @movie = Tmdb::Movie.images(22855)
      end
    end

    it "should return backdrops" do
      @movie['backdrops'].length == 4
    end

    it "should return posters" do
      @movie['posters'].should be_true
    end

  end

  describe "For other languages" do

    before(:each) do
      Tmdb::Api.language("de")
      VCR.use_cassette 'movie/language_german' do
        @movie = Tmdb::Movie.detail(562)
      end
      Tmdb::Api.language(nil)
    end

    it "should return the german name" do
      @movie['title'].should == "Stirb Langsam"
    end

    it "should return the german description" do
      @movie['overview'].should == "Eigentlich möchte der New Yorker Polizist John McClane dieses Weihnachten nur seine Noch-Ehefrau Holly, welche in Los Angeles in einer großen, erfolgreichen Firma Karriere gemacht hat, besuchen und das Fest mit den beiden gemeinsamen Kinder verbringen. Als die Feierlichkeiten im Nakatomi Plaza beginnen sollen, stürmt eine Gruppe von Terroristen das Hochhaus und nur John McClane schafft es ihnen zu entwischen. Lediglich bewaffnet mit ein paar Zigaretten und einem Walkie-Talkie, wodurch er den Funk der Geiselnehmer mithören kann, und mit Waffen, welche die Terroristen gelegentlich so rumliegen lassen, muss John nun nicht nur sein eigenes Leben retten, sondern möglichst auch das aller anderen Beteiligten. Und so beschließt er, die äußerst brutale Truppe auszumerzen und sich einen Terroristen nach dem anderen vorzuknöpfen. Während draußen dann schon die Polizei und das FBI stümperhaft versucht, das Gebäude zu stürmen, kämpft McClane ohne Schuhe gegen die 12 Aggressoren..."
    end

  end

end
