# encoding: utf-8
module Wanikani
  class RecentUnlocks
    def self.list(limit = 10)
      api_response = Wanikani.api_response("recent-unlocks", limit)
      return api_response["requested_information"]
    end
  end
end
