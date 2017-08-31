# -*- encoding : utf-8 -*-
module Wanikani
  module Level
    # Gets the user's current level progression (radicals and Kanji).
    #
    # @return [Hash] Progress and total of radicals and Kanji for the user's current level.
    def level_progression
      response = api_response("level-progression")
      current_level = { "current_level" => response["user_information"]["level"] }
      return response["requested_information"].merge(current_level)
    end

    # Gets the full response of the Level Progression API call.
    #
    # @return [Hash] Full response from the Level Progression API call.
    def full_level_progression_response
      return api_response("level-progression")
    end

    private

    def method_missing(name, *args)
      super unless [:radicals_list, :kanji_list, :vocabulary_list].include?(name)

      levels = args.push
      levels = levels.join(',') if levels.is_a?(Array)
      response = api_response(name.to_s.gsub("_list", ""), levels)

      # The vocabulary API call without specifying levels returns a Hash instead
      # of an Array, so this is a hacky way of dealing with it.
      if response["requested_information"].is_a?(Hash)
        return response["requested_information"]["general"]
      else
        return response["requested_information"]
      end
    end
  end
end
