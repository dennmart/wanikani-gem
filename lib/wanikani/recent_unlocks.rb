# -*- encoding : utf-8 -*-
module Wanikani
  class RecentUnlocks
    # Gets the recent unlocked items (radicals, Kanji and vocabulary).
    #
    # @param [Integer] limit the total number of items returned.
    # @return [Array] Returns hashes of unlocked items and related information.
    def self.list(limit = 10)
      api_response = Wanikani.api_response("recent-unlocks", limit)
      return api_response["requested_information"]
    end

    # Gets the recent unlocked radicals.
    #
    # @param [Integer] limit the total number of items returned.
    # @return [Array] Returns hashes of unlocked radicals and related information.
    def self.radicals(limit = 10)
      unlock_list = self.list(limit)
      return unlock_list.select { |unlock| unlock["type"] == "radical" }
    end

    # Gets the recent unlocked vocabulary.
    #
    # @param [Integer] limit the total number of items returned.
    # @return [Array] Returns hashes of unlocked vocabulary and related information.
    def self.vocabulary(limit = 10)
      unlock_list = self.list(limit)
      return unlock_list.select { |unlock| unlock["type"] == "vocabulary" }
    end

    # Gets the recent unlocked Kanji.
    #
    # @param [Integer] limit the total number of items returned.
    # @return [Array] Returns hashes of unlocked Kanji and related information.
    def self.kanji(limit = 10)
      unlock_list = self.list(limit)
      return unlock_list.select { |unlock| unlock["type"] == "kanji" }
    end
  end
end
