# -*- encoding : utf-8 -*-
module Wanikani
  class SRS
    ITEM_TYPES = %w(apprentice guru master enlighten burned all)

    # Gets the counts for each SRS level and item types.
    #
    # @param [String] item_type the SRS level that will be returned.
    # @return [Hash] Returns the SRS information for each level for the user.
    def self.distribution(item_type = "all")
      raise ArgumentError, "Please use a valid SRS type (or none for all types)" if !ITEM_TYPES.include?(item_type)

      api_response = Wanikani.api_response("srs-distribution")
      srs_distribution = api_response["requested_information"]

      return srs_distribution if item_type == "all"
      return srs_distribution[item_type]
    end
  end
end
