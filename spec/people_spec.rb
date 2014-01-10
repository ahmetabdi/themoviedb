#encoding: utf-8
require 'rspec'
require 'spec_helper'
require 'vcr'

describe Tmdb::People do

  @fields = [:id,:name,:place_of_birth,:also_known_as,
             :adult,:biography,:birthday,:deathday,:homepage,
             :profile_path]

  @fields.each do |field|
    it { should respond_to field }
  end

  describe "For people" do
    before(:each) do
      @people = Tmdb::People
    end

    it "should return the popular people" do
      VCR.use_cassette 'people/popular' do
        @people.popular.should be_true
      end
    end
  end
end
