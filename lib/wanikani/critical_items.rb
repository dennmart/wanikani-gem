# -*- encoding : utf-8 -*-
module Wanikani
  module CriticalItems
    # Gets the user's current items under 'Critical Items'.
    #
    # @param [Integer] percentage maximum percentage
    # @return [Array] Returns hashes of critical items and their related information.
    def critical_items(percentage = 75)
      raise ArgumentError, "Percentage must be an Integer between 0 and 100" if !percentage.between?(0, 100)
      response = api_response("critical-items", percentage)
      return response["requested_information"]
    end

    # Gets the full response of the Critical Items List API call.
    #
    # @param [Integer] percentage maximum percentage
    # @return [Hash] Full response from the Critical Items List API call.
    def full_critical_items_response(percentage = 75)
      raise ArgumentError, "Percentage must be an Integer between 0 and 100" if !percentage.between?(0, 100)
      return api_response("critical-items", percentage)
    end
  end
end
