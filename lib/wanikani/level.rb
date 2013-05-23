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

    # Gets the radicals for the specified levels.
    #
    # @param [Integer, Array] levels returns the list of radicals for one or more levels
    # @return [Array] Hashes with the radicals for the specified level(s).
    def self.radicals(levels = nil)
      levels = levels.join(',') if levels.is_a?(Array)
      api_response = Wanikani.api_response("radicals", levels)
      return api_response["requested_information"]
    end

    # Gets the Kanji for the specified levels.
    #
    # @param [Integer, Array] levels returns the list of Kanji for one or more levels
    # @return [Array] Hashes with the Kanji for the specified level(s).
    def self.kanji(levels = nil)
      levels = levels.join(',') if levels.is_a?(Array)
      api_response = Wanikani.api_response("kanji", levels)
      return api_response["requested_information"]
    end

    # Gets the vocabulary for the specified levels.
    #
    # @param [Integer, Array] levels returns the list of vocabulary for one or more levels
    # @return [Array] Hashes with the vocabulary for the specified level(s).
    def self.vocabulary(levels = nil)
      levels = levels.join(',') if levels.is_a?(Array)
      api_response = Wanikani.api_response("vocabulary", levels)
      return api_response["requested_information"]
    end
  end
end
