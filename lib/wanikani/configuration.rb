module Wanikani
  class Configuration
    attr_accessor :api_revision, :api_key

    def initialize(configuration)
      @api_revision = configuration.fetch(:api_revision)
    end

    def to_hash
      {
        api_revision: api_revision,
        api_key: api_key
      }
    end
  end
end
