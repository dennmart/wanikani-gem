# -*- encoding : utf-8 -*-
module Wanikani
  module RecentUnlocks
    # Gets the recent unlocked items (radicals, Kanji and vocabulary).
    #
    # @param [Integer] limit the total number of items returned.
    # @param [String] type the type of item returned.
    # @return [Array] Returns hashes of unlocked items and related information.
    def recent_unlocks(limit = 10, type = nil)
      response = api_response("recent-unlocks", limit)
      if type.nil?
        return response["requested_information"]
      else
        return response["requested_information"].select { |unlock| unlock["type"] == type }
      end
    end

    # Gets the full response of the Recents Unlocks List API call.
    #
    # @param [Integer] limit the total number of items returned.
    # @return [Hash] Full response from the Recent Unlocks List API call.
    def full_recent_unlocks_response(limit = 10)
      return api_response("recent-unlocks", limit)
    end
  end
end
