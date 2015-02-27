# -*- encoding : utf-8 -*-
module Wanikani
  class StudyQueue
    # Get the number of lessons and reviews that are currently in the user's queue.
    #
    # @return [Hash] Returns the number of lessons and reviews pending, along with upcoming review information.
    def self.queue
      api_response = Wanikani.api_response("study-queue")
      return api_response["requested_information"]
    end

    # Check if there are lessons available.
    #
    # @return [Boolean] Returns true if there's at least one lesson available, or false if there are none.
    def self.lessons_available?
      return !self.queue["lessons_available"].zero?
    end

    # Check if there are reviews available.
    #
    # @return [Boolean] Returns true if there's at least one review available, or false if there are none.
    def self.reviews_available?
      return !self.queue["reviews_available"].zero?
    end

    # Gets the full response of the Study Queue API call.
    #
    # @return [Hash] Full response from the Study Queue API call.
    def self.full_response
      return Wanikani.api_response("study-queue")
    end
  end
end
