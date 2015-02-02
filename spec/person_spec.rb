#encoding: utf-8
require 'rspec'
require 'spec_helper'
require 'vcr'

describe Tmdb::Person do
  @fields = [:id,:name,:place_of_birth,:also_known_as,
             :adult,:biography,:birthday,:deathday,:homepage,
             :profile_path,:movie_credits,:tv_credits,:combined_credits,
             :images,:changes]

  @fields.each do |field|
    it { should respond_to field }
  end

  describe "For person p" do
    before(:each) do
      @person = Tmdb::Person
    end

    it "should return the popular people" do
      VCR.use_cassette 'person/popular' do
        @person.popular.should be_true
      end
    end

    it "should return the latest person" do
      VCR.use_cassette 'person/latest' do
        @person.latest.should be_true
      end
    end

    it "should return credits for a person ID" do
      VCR.use_cassette 'person/credits' do
        @person.credits(5292).should be_true
      end
    end

    it "should return changes for a person ID" do
      VCR.use_cassette 'person/changes' do
        @person.changes(5292).should be_true
      end
    end
  end

  describe "For a person detail" do
    before(:each) do
      VCR.use_cassette 'person/detail' do
        @person = Tmdb::Person.detail(5292)
      end
    end

    it "should return a id" do
      @person['id'].should == 5292
    end

    it "should return a name" do
      @person['name'].should == "Denzel Washington"
    end

    it "should return a adult" do
      @person['adult'].should == false
    end

    it "should return a biography" do
      @person['biography'].should == "From Wikipedia, the free encyclopedia.\n\nDenzel Hayes Washington, Jr. (born December 28, 1954) is an American actor, screenwriter, director and film producer. He first rose to prominence when he joined the cast of the medical drama St. Elsewhere, playing Dr. Philip Chandler for six years. He has received much critical acclaim for his work in film since the 1990s, including for his portrayals of real-life figures, such as Steve Biko, Malcolm X, Rubin \"Hurricane\" Carter, Melvin B. Tolson, Frank Lucas, and Herman Boone.\n\nWashington has received two Academy Awards, two Golden Globe awards, a Tony Award. He is notable for winning the Best Supporting Actor for Glory in 1989; and the Academy Award for Best Actor in 2001 for his role in the film Training Day\n\nDescription above from the Wikipedia article Denzel Washington, licensed under CC-BY-SA, full list of contributors on Wikipedia."
    end

    it "should return a birthday" do
      @person['birthday'].should == "1954-12-28"
    end

    it "should return a deathday" do
      @person['deathday'].should == ""
    end

    it "should return a homepage" do
      @person['homepage'].should == ""
    end

    it "should return a place of birth" do
      @person['place_of_birth'].should == "Mount Vernon, New York, USA"
    end

    it "should return a profile path" do
      @person['profile_path'].should == "/khMf8LLTtppUwuZqqnigD2nAy26.jpg"
    end

    it "should return an array with also known as names" do
      @person['also_known_as'].should == []
    end
  end

  describe 'For a person detail with appended response' do
    let(:append_fields) { %w{ movie_credits tv_credits combined_credits images changes }.join(',') }

    before(:each) do
      VCR.use_cassette 'person/detail_with_appended_response' do
        @person = Tmdb::Person.detail(5292, append_to_response: append_fields)
      end
    end

    it 'should return movie credits' do
      @person['movie_credits']['cast'].size.should == 47
      @person['movie_credits']['cast'].first['id'].should == 388
      @person['movie_credits']['crew'].size.should == 4
      @person['movie_credits']['crew'].first['id'].should == 13435
    end

    it 'should return tv credits' do
      @person['tv_credits']['cast'].size.should == 17
      @person['tv_credits']['cast'].first['id'].should == 1709
      @person['tv_credits']['crew'].size.should == 3
      @person['tv_credits']['crew'].first['id'].should == 18881
    end

    it 'should return combined credits' do
      @person['combined_credits']['cast'].size.should == 64
      @person['combined_credits']['cast'].first['id'].should == 388
      @person['combined_credits']['crew'].size.should == 7
      @person['combined_credits']['crew'].first['id'].should == 13435
    end

    it 'should return images' do
      @person['images']['profiles'].size.should == 6
      @person['images']['profiles'].first['file_path'].should == '/khMf8LLTtppUwuZqqnigD2nAy26.jpg'
    end

    it 'should return changes' do
      @person['changes']['changes'].should == []
    end
  end

  describe "For images of a person" do
    before(:each) do
      VCR.use_cassette 'person/images' do
        @person_images = Tmdb::Person.images(5292)
      end
    end

    it "should return profiles" do
      @person_images['profiles'].length == 6
    end
  end
end
