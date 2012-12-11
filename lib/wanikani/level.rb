module Wanikani
  class Level
    def self.progression
      api_response = Wanikani.api_response("level-progression")
      return api_response["requested_information"]
    end
  end
end
