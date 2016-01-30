# encoding: utf-8
require 'rspec'
require 'spec_helper'
require 'vcr'

describe Tmdb::Person do
  @fields = [:id, :name, :place_of_birth, :also_known_as,
             :adult, :biography, :birthday, :deathday, :homepage,
             :profile_path, :movie_credits, :tv_credits, :combined_credits,
             :images, :changes]

  @fields.each do |field|
    it { should respond_to field }
  end

  describe 'For person p' do
    before(:each) do
      @person = Tmdb::Person
    end

    it 'should return the popular people' do
      VCR.use_cassette 'person/popular' do
        expect(@person.popular).to be_truthy
      end
    end

    it 'should return the latest person' do
      VCR.use_cassette 'person/latest' do
        expect(@person.latest).to be_truthy
      end
    end

    it 'should return credits for a person ID' do
      VCR.use_cassette 'person/credits' do
        expect(@person.credits(5292)).to be_truthy
      end
    end

    it 'should return changes for a person ID' do
      VCR.use_cassette 'person/changes' do
        expect(@person.changes(5292)).to be_truthy
      end
    end
  end

  describe 'For a person detail' do
    before(:each) do
      VCR.use_cassette 'person/detail' do
        @person = Tmdb::Person.detail(5292)
      end
    end

    it 'should return a id' do
      expect(@person['id']).to eq 5292
    end

    it 'should return a name' do
      expect(@person['name']).to eq 'Denzel Washington'
    end

    it 'should return a adult' do
      expect(@person['adult']).to eq false
    end

    it 'should return a biography' do
      expect(@person['biography']).to eq "From Wikipedia, the free encyclopedia.\n\nDenzel Hayes Washington, Jr. (born December 28, 1954) is an American actor, screenwriter, director and film producer. He first rose to prominence when he joined the cast of the medical drama St. Elsewhere, playing Dr. Philip Chandler for six years. He has received much critical acclaim for his work in film since the 1990s, including for his portrayals of real-life figures, such as Steve Biko, Malcolm X, Rubin \"Hurricane\" Carter, Melvin B. Tolson, Frank Lucas, and Herman Boone.\n\nWashington has received two Academy Awards, two Golden Globe awards, a Tony Award. He is notable for winning the Best Supporting Actor for Glory in 1989; and the Academy Award for Best Actor in 2001 for his role in the film Training Day\n\nDescription above from the Wikipedia article Denzel Washington, licensed under CC-BY-SA, full list of contributors on Wikipedia."
    end

    it 'should return a birthday' do
      expect(@person['birthday']).to eq '1954-12-28'
    end

    it 'should return a deathday' do
      expect(@person['deathday']).to eq ''
    end

    it 'should return a homepage' do
      expect(@person['homepage']).to eq ''
    end

    it 'should return a place of birth' do
      expect(@person['place_of_birth']).to eq 'Mount Vernon, New York, USA'
    end

    it 'should return a profile path' do
      expect(@person['profile_path']).to eq '/khMf8LLTtppUwuZqqnigD2nAy26.jpg'
    end

    it 'should return an array with also known as names' do
      expect(@person['also_known_as']).to eq []
    end
  end

  describe 'For a person detail with appended response' do
    let(:append_fields) { %w( movie_credits tv_credits combined_credits images changes ).join(',') }

    before(:each) do
      VCR.use_cassette 'person/detail_with_appended_response' do
        @person = Tmdb::Person.detail(5292, append_to_response: append_fields)
      end
    end

    it 'should return movie credits' do
      expect(@person['movie_credits']['cast'].size).to eq 47
      expect(@person['movie_credits']['cast'].first['id']).to eq 388
      expect(@person['movie_credits']['crew'].size).to eq 4
      expect(@person['movie_credits']['crew'].first['id']).to eq 13_435
    end

    it 'should return tv credits' do
      expect(@person['tv_credits']['cast'].size).to eq 17
      expect(@person['tv_credits']['cast'].first['id']).to eq 1709
      expect(@person['tv_credits']['crew'].size).to eq 3
      expect(@person['tv_credits']['crew'].first['id']).to eq 18_881
    end

    it 'should return combined credits' do
      expect(@person['combined_credits']['cast'].size).to eq 64
      expect(@person['combined_credits']['cast'].first['id']).to eq 388
      expect(@person['combined_credits']['crew'].size).to eq 7
      expect(@person['combined_credits']['crew'].first['id']).to eq 13_435
    end

    it 'should return images' do
      expect(@person['images']['profiles'].size).to eq 6
      expect(@person['images']['profiles'].first['file_path']).to eq '/khMf8LLTtppUwuZqqnigD2nAy26.jpg'
    end

    it 'should return changes' do
      expect(@person['changes']['changes']).to eq []
    end
  end

  describe 'For images of a person' do
    before(:each) do
      VCR.use_cassette 'person/images' do
        @person_images = Tmdb::Person.images(5292)
      end
    end

    it 'should return profiles' do
      @person_images['profiles'].length == 6
    end
  end
end
