require 'spec_helper'

describe Tmdb::Movie do
  before(:each) do
    @tmdb = Tmdb.connect('8a221fc31fcdf12a8af827465574ffc9')
  end

  describe 'public class methods' do
    subject { described_class }

    context 'responds to its methods' do
      it { expect(subject).to respond_to(:find) }
      it { expect(subject).to respond_to(:latest) }
      it { expect(subject).to respond_to(:now_playing) }
      it { expect(subject).to respond_to(:popular) }
      it { expect(subject).to respond_to(:top_rated) }
      it { expect(subject).to respond_to(:upcoming) }
    end

    context '.latest' do
      it 'should return the latest movie' do
        VCR.use_cassette 'movie/latest' do
          expect(subject.latest.class).to eq(Tmdb::Movie)
        end
      end
    end

    context '.upcoming' do
      it 'should return the upcoming movies' do
        VCR.use_cassette 'movie/upcoming/default' do
          expect(subject.upcoming).to include(Tmdb::Movie)
        end
      end

      it 'should return upcoming movies in any language' do
        @tmdb.language = 'fr'
        VCR.use_cassette 'movie/upcoming/language' do
          expect(subject.upcoming).to include(Tmdb::Movie)
        end
      end

      it 'should returned paged results' do
        VCR.use_cassette 'movie/upcoming/paged' do
          upcoming_page_1 = subject.upcoming(page: 1)
          upcoming_page_2 = subject.upcoming(page: 2)
          expect(upcoming_page_1).not_to eq(upcoming_page_2)
        end
      end
    end

    context '.now_playing' do
      it 'should return movies that are now playing in cinemas' do
        VCR.use_cassette 'movie/now_playing/default' do
          expect(subject.now_playing).to include(Tmdb::Movie)
        end
      end

      it 'should return now playing movies in any language' do
        @tmdb.language = 'fr'
        VCR.use_cassette 'movie/now_playing/language' do
          expect(subject.now_playing).to include(Tmdb::Movie)
        end
      end

      it 'should returned paged results' do
        VCR.use_cassette 'movie/now_playing/paged' do
          now_playing_page_1 = subject.now_playing(page: 1)
          now_playing_page_2 = subject.now_playing(page: 2)
          expect(now_playing_page_1).not_to eq(now_playing_page_2)
        end
      end
    end

    context '.popular' do
      it 'should return popular movies' do
        VCR.use_cassette 'movie/popular/default' do
          expect(subject.popular).to include(Tmdb::Movie)
        end
      end

      it 'should return popular movies in any language' do
        @tmdb.language = 'fr'
        VCR.use_cassette 'movie/popular/language' do
          expect(subject.popular).to include(Tmdb::Movie)
        end
      end

      it 'should returned paged results' do
        VCR.use_cassette 'movie/popular/paged' do
          popular_page_1 = subject.popular(page: 1)
          popular_page_2 = subject.popular(page: 2)
          expect(popular_page_1).not_to eq(popular_page_2)
        end
      end
    end

    context '.top_rated' do
      it 'should return top rated movies' do
        VCR.use_cassette 'movie/top_rated/default' do
          expect(subject.top_rated).to include(Tmdb::Movie)
        end
      end

      it 'should return top rated movies in any language' do
        @tmdb.language = 'fr'
        VCR.use_cassette 'movie/top_rated/language' do
          expect(subject.top_rated).to include(Tmdb::Movie)
        end
      end

      it 'should returned paged results' do
        VCR.use_cassette 'movie/top_rated/paged' do
          top_rated_page_1 = subject.top_rated(page: 1)
          top_rated_page_2 = subject.top_rated(page: 2)
          expect(top_rated_page_1).not_to eq(top_rated_page_2)
        end
      end
    end

    context '.find' do
      let(:movie) { VCR.use_cassette('movie/find/default') { Tmdb::Movie.find(22855) } }

      context 'responds to its methods' do
        [:adult,
         :backdrop_path,
         :genres,
         :id,
         :original_language,
         :original_title,
         :overview,
         :release_date,
         :poster_path,
         :popularity,
         :title,
         :video,
         :vote_average,
         :vote_count,
         :belongs_to_collection,
         :budget,
         :genres,
         :homepage,
         :imdb_id,
         :production_companies,
         :production_countries,
         :revenue,
         :runtime,
         :spoken_languages,
         :status,
         :tagline].each do |field|
          it { expect(movie).to respond_to(field) }
        end

        it 'should respond with a language code' do
          @tmdb.language = 'fr'
          VCR.use_cassette 'movie/find/language' do
            expect(Tmdb::Movie.find(22855).title).to eq('SuperMan/Batman: Ennemis publics')
          end
        end

        it 'should respond with append_to_response options' do
          VCR.use_cassette 'movie/find/append_to_response' do
            expect(Tmdb::Movie.find(22855, append: ['alternative_titles']).alternative_titles).not_to be_nil
          end
        end

        it 'should not respond with append_to_response options' do
          VCR.use_cassette 'movie/find/empty_append_to_response' do
            expect(Tmdb::Movie.find(22855).alternative_titles).to eq(nil)
          end
        end
      end
    end
  end

  describe 'public instance methods' do
    subject { described_class.new }

    context '#account_states' do
      context 'with a session_id' do
      end

      context 'without a session_id' do
      end
    end

    context '#alternative_titles' do
      context 'it responds' do
      end

      context 'with a language code' do
      end

      context 'with append_to_response options' do
      end
    end

    context '#credits' do
      context 'it responds' do
      end

      context 'with append_to_response options' do
      end
    end

    context '#images' do
      context 'it responds' do
      end

      context 'with a language code' do
      end

      context 'with append_to_response options' do
      end

      context 'with include_image_language' do
      end
    end

    context '#keywords' do
      context 'it responds' do
      end

      context 'with append_to_response options' do
      end
    end

    context '#releases' do
      context 'it responds' do
      end

      context 'with append_to_response options' do
      end
    end

    context '#videos' do
      context 'it responds' do
      end

      context 'with append_to_response options' do
      end
    end

    context '#translations' do
      context 'it responds' do
      end

      context 'with append_to_response options' do
      end
    end

    context '#similar' do
      context 'it responds' do
      end

      context 'with a page' do
      end

      context 'with a language code' do
      end

      context 'with append_to_response options' do
      end
    end

    context '#reviews' do
      context 'it responds' do
      end

      context 'with a page' do
      end

      context 'with a language code' do
      end

      context 'with append_to_response options' do
      end
    end

    context '#lists' do
      context 'it responds' do
      end

      context 'with a page' do
      end

      context 'with a language code' do
      end

      context 'with append_to_response options' do
      end
    end

    context '#changes' do
      context 'it responds' do
      end

      context 'with a start date' do
      end

      context 'with a end date' do
      end

      context 'with both start and end date' do
      end
    end

    context '#rate' do
      context 'with a session_id' do
      end

      context 'with a guest_session_id' do
      end

      context 'with a POST request with the value as the body' do
      end

      context 'with a POST request with a empty body' do
      end

      context 'with a DELETE request' do
      end
    end
  end
end
