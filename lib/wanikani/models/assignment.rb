# -*- encoding : utf-8 -*-
module Wanikani
  module Assignment
    class << self
      PERMITTED_PARAMS = %w[available_after available_before burned hidden ids immediately_available_for_lessons immediately_available_for_review in_review levels passed srs_stages started subject_ids subject_types unlocked updated_after page_after_id page_before_id].freeze

      def find_by(parameters = {})
        respond(client.get('assignments', filter(parameters)))
      end

      def find(id)
        respond(client.get("assignments/#{id}"))
      end

      private

      def respond(json)
        Response.new(json)
      end

      def filter(parameters)
        parameters.keep_if { |key, value| PERMITTED_PARAMS.include?(key.to_s) }
      end

      def client
        @client ||= ::Wanikani::Client.new(::Wanikani.config.to_hash)
      end
    end
  end
end
