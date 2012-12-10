module Wanikani
  class User
    def self.information
      api_response = Wanikani.api_response("user-information")
      return api_response["user_information"]
    end
  end
end
