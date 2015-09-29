require 'representable/json'

class Tmdb::ApiResource < OpenStruct

  private
  def self.build_single_resource(response, representer)
    return unless response
    self.new.extend(representer).from_hash(response)
  end

  def self.build_collection(response, representer)
    response.reduce([]) do |resources, response|
      resources << self.new.extend(representer).from_hash(response)
    end
  end

  def build_for_collection(response, representer)
    [].extend(representer.for_collection).from_hash(response)
  end
end
