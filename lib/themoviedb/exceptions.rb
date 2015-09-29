module Tmdb::Exception
  class Base < ::Exception
    def initialize(message)
      super(message)
    end
  end

  class Api < Base; end
  class ArgumentError < Base; end
  class JsonParseError < Base; end
end
