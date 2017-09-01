# -*- encoding : utf-8 -*-
module Wanikani
  module StudyQueue
    # Get the number of lessons and reviews that are currently in the user's queue.
    #
    # @return [Hash] the number of lessons and reviews pending, along with upcoming review information.
    def study_queue
      response = api_response("study-queue")
      return response["requested_information"]
    end

    # Check if there are lessons available.
    #
    # @return [Boolean] true if there's at least one lesson available, or false if there are none.
    def lessons_available?
      return !study_queue["lessons_available"].zero?
    end

    # Check if there are reviews available.
    #
    # @return [Boolean] true if there's at least one review available, or false if there are none.
    def reviews_available?
      return !study_queue["reviews_available"].zero?
    end

    # Gets the full response of the Study Queue API call.
    #
    # @return [Hash] full response from the Study Queue API call.
    def full_study_queue_response
      return api_response("study-queue")
    end
  end
end
