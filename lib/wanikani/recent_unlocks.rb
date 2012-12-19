# -*- encoding : utf-8 -*-
module Wanikani
  class RecentUnlocks
    def self.list(limit = 10)
      api_response = Wanikani.api_response("recent-unlocks", limit)
      return api_response["requested_information"]
    end

    def self.radicals(limit = 10)
      unlock_list = self.list(limit)
      return unlock_list.select { |unlock| unlock["type"] == "radical" }
    end

    def self.vocabulary(limit = 10)
      unlock_list = self.list(limit)
      return unlock_list.select { |unlock| unlock["type"] == "vocabulary" }
    end

    def self.kanji(limit = 10)
      unlock_list = self.list(limit)
      return unlock_list.select { |unlock| unlock["type"] == "kanji" }
    end
  end
end
