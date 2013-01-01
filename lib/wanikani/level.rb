# -*- encoding : utf-8 -*-
module Wanikani
  class Level
    # Gets the user's current level progression (radicals and Kanji).
    #
    # @return [Hash] Progress and total of radicals and Kanji for the user's current level.
    def self.progression
      api_response = Wanikani.api_response("level-progression")
      return api_response["requested_information"]
    end
  end
end
