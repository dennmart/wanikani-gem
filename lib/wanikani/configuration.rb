module Wanikani
  class Configuration
    attr_accessor :api_version, :api_revision, :api_key

    def initialize(configuration)
      @api_version = configuration.fetch(:api_version)
    end

    def to_hash
      {
        api_version: api_version,
        api_revision: api_revision,
        api_key: api_key
      }
    end
  end
end
