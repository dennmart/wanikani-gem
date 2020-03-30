# -*- encoding : utf-8 -*-
module Wanikani::ApiV2
  module User
    # Gets the user information from WaniKani.
    #
    # @return [Hash] the user information for the WaniKani account by from
    #   the API key.
    def user
      response['data']
    end

    alias_method :user_information, :user

    # Checks if the user is currently in vacation mode.
    #
    # @return [Boolean] true if current_vacation_started_at contains a
    #   timestamp, false if current_vacation_started_at is null.
    def on_vacation?
      vacation_date = user['current_vacation_started_at']
      return !vacation_date.nil?
    end

    # Gets the full response of the User Information API call.
    #
    # @return [Hash] full response from the User Information API call.
    def full_user_response
      response
    end

    private

    def response
      api_response('user')
    end
  end
end
