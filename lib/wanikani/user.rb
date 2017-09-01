# -*- encoding : utf-8 -*-
module Wanikani
  module User
    # Gets the user information from WaniKani.
    #
    # @return [Hash] the user information for the WaniKani account by from the API key.
    def user_information
      response = api_response("user-information")
      return response["user_information"]
    end

    # Checks if the user is currently in vacation mode.
    #
    # @return [Boolean] true if vacation_date contains a timestamp, false if
    #   vacation_date is null.
    def on_vacation?
      response = api_response("user-information")
      vacation_date = response["user_information"]["vacation_date"]
      return !vacation_date.nil?
    end

    # Returns the Gravatar image URL using the Gravatar hash from the user's information.
    #
    # @param options [Hash] optional settings for the gravatar URL.
    # @return [String, nil] the Gravatar URL, with the optional size parameter, nil if
    #   the user information contains no Gravatar hash.
    def gravatar_url(options = {})
      raise ArgumentError, "The size parameter must be an integer" if options[:size] && !options[:size].is_a?(Integer)
      response = api_response("user-information")
      hash = response["user_information"]["gravatar"]

      return nil if hash.nil?
      return build_gravatar_url(hash, options)
    end

    # Gets the full response of the User Information API call.
    #
    # @return [Hash] full response from the User Information API call.
    def full_user_response
      return api_response("user-information")
    end

    private

    # Builds the URL for displaying the Gravatar URL with different params.
    #
    # @param hash [String] the Gravatar hash for the user's image.
    # @param options [Hash] optional params for building the Gravatar URL.
    # @return [String] the Gravatar URL according to the specified params.
    def build_gravatar_url(hash, options = {})
      params = "d=mm" # Use 'Mystery Man' image if no image found.
      params += "&size=#{options[:size]}" if options[:size]

      return "https://secure.gravatar.com/avatar/#{hash}?#{params}" if options[:secure]
      return "http://www.gravatar.com/avatar/#{hash}?#{params}"
    end
  end
end
