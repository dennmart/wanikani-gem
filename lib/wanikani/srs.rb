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

    # Gets all items for a specific SRS level.
    #
    # @param [String] item_type the SRS level for the items returned.
    # @return [Array] Returns all the items matching the specified SRS for each level for the user.
    def self.items_by_type(item_type)
      raise ArgumentError, "Please use a valid SRS type." if !ITEM_TYPES.include?(item_type) || item_type == "all"

      items_by_type = []
      %w(radicals kanji vocabulary).each do |type|
        items = Wanikani::Level.send(type)
        items.reject! { |item| item["user_specific"].nil? || item["user_specific"]["srs"] != item_type }.map! do |item|
          item.merge!("type" => (type == 'radicals' ? 'radical' : type))
        end
        items_by_type << items
      end

      items_by_type.flatten
    end

    # Gets the full response of the SRS Distribution API call.
    #
    # @return [Hash] Full response from the SRS Distribution API call.
    def self.full_response
      return Wanikani.api_response("srs-distribution")
    end
  end
end
