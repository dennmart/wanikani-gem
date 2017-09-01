# -*- encoding : utf-8 -*-
module Wanikani
  module RecentUnlocks
    # Gets the recent unlocked items (radicals, Kanji and vocabulary).
    #
    # @param options [Hash] the options to limit the number and type of items.
    # @return [Array] Returns hashes of unlocked items and related information.
    def recent_unlocks(options = {})
      response = api_response("recent-unlocks", options[:limit])
      if options[:type]
        return response["requested_information"].select { |unlock| unlock["type"] == options[:type] }
      else
        return response["requested_information"]
      end
    end

    # Gets the full response of the Recents Unlocks List API call.
    #
    # @param [Integer] limit the total number of items returned.
    # @return [Hash] Full response from the Recent Unlocks List API call.
    def full_recent_unlocks_response(options = {})
      return api_response("recent-unlocks", options[:limit])
    end
  end
end
