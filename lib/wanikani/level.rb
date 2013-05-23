# -*- encoding : utf-8 -*-
module Wanikani
  class Level
    # Gets the user's current level progression (radicals and Kanji).
    #
    # @return [Hash] Progress and total of radicals and Kanji for the user's current level.
    def self.progression
      api_response = Wanikani.api_response("level-progression")
      current_level = { "current_level" => api_response["user_information"]["level"] }
      return api_response["requested_information"].merge(current_level)
    end

    private

    def self.method_missing(name, *args)
      super unless [:radicals, :kanji, :vocabulary].include?(name)

      levels = args.push
      levels = levels.join(',') if levels.is_a?(Array)
      api_response = Wanikani.api_response(name.to_s, levels)
      return api_response["requested_information"]
    end
  end
end
