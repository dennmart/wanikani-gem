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

    # Returns the Gravatar image URL using the Gravatar hash from the user's information.
    #
    # @param options [Hash] Optional settings for the gravatar URL.
    # @return [String] The Gravatar URL, with the optional size parameter, nil if
    #   the user information contains no Gravatar hash.
    def self.gravatar_url(options = {})
      raise ArgumentError, "The size parameter must be an integer" if options[:size] && !options[:size].is_a?(Integer)
      api_response = Wanikani.api_response("user-information")
      hash = api_response["user_information"]["gravatar"]

      return nil if hash.nil?
      return build_gravatar_url(hash, options)
    end

    # Gets the full response of the User Information API call.
    #
    # @return [Hash] Full response from the User Information API call.
    def self.full_response
      return Wanikani.api_response("user-information")
    end

    private

    def self.build_gravatar_url(hash, options)
      params = "d=mm" # Use 'Mystery Man' image if no image found.
      params += "&size=#{options[:size]}" if options[:size]

      return "https://secure.gravatar.com/avatar/#{hash}?#{params}" if options[:secure]
      return "http://www.gravatar.com/avatar/#{hash}?#{params}"
    end
  end
end
