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

    # Checks if the user is currently in vacation mode.
    #
    # @return [Boolean] true if vacation_date contains a timestamp, false if
    #   vacation_date is null.
    def self.on_vacation?
      api_response = Wanikani.api_response("user-information")
      vacation_date = api_response["user_information"]["vacation_date"]
      return !vacation_date.nil?
    end
  end
end
