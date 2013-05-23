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

    private

    def self.method_missing(name, *args)
      super unless [:radicals, :vocabulary, :kanji].include?(name)

      limit = args.shift || 10
      type = name == :radicals ? name.to_s.chop! : name.to_s
      unlock_list = self.list(limit)
      return unlock_list.select { |unlock| unlock["type"] == type }
    end
  end
end
