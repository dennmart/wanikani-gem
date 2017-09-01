# -*- encoding : utf-8 -*-
module Wanikani
  module Level
    # Gets the user's current level progression (radicals and Kanji).
    #
    # @return [Hash] progress and total of radicals and Kanji for the user's current level.
    def level_progression
      response = api_response("level-progression")
      current_level = { "current_level" => response["user_information"]["level"] }
      return response["requested_information"].merge(current_level)
    end

    # Gets the user's full list of radicals and stats.
    #
    # @param levels [Integer, Array<Integer>] a specific level or array of
    #   levels to fetch items for.
    # @return [Hash] radicals with the user's stats.
    def radicals_list(levels = nil)
      return level_items_list("radicals", levels)
    end

    # Gets the user's full list of kanji and stats.
    #
    # @param levels [Integer, Array<Integer>] a specific level or array of
    #   levels to fetch items for.
    # @return [Hash] kanji with the user's stats.
    def kanji_list(levels = nil)
      return level_items_list("kanji", levels)
    end

    # Gets the user's full list of vocabulary and stats.
    #
    # @param levels [Integer, Array<Integer>] a specific level or array of
    #   levels to fetch items for.
    # @return [Hash] vocabulary with the user's stats.
    def vocabulary_list(levels = nil)
      return level_items_list("vocabulary", levels)
    end

    # Gets the full response of the Level Progression API call.
    #
    # @return [Hash] full response from the Level Progression API call.
    def full_level_progression_response
      return api_response("level-progression")
    end

    private

    # Fetches the specified item type list from WaniKani's API
    #
    # @param type [String] The type of item to fetch.
    # @param levels [Integer, Array<Integer>] a specific level or array of
    #   levels to fetch items for.
    # @return [Hash] list of items of the specified type and levels.
    def level_items_list(type, levels)
      levels = levels.join(',') if levels.is_a?(Array)
      response = api_response(type, levels)

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
