module Wanikani
  class StudyQueue
    def self.queue
      api_response = Wanikani.api_response("study-queue")
      return api_response["requested_information"]
    end

    def self.lessons_available?
      return !self.queue["lessons_available"].zero?
    end

    def self.reviews_available?
      return !self.queue["reviews_available"].zero?
    end
  end
end
