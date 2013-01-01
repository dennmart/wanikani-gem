# -*- encoding : utf-8 -*-
module Wanikani
  class User
    # Gets the user information from WaniKani.
    #
    # @return [Hash] The user information for the WaniKani account by from the API key.
    def self.information
      api_response = Wanikani.api_response("user-information")
      return api_response["user_information"]
    end
  end
end
