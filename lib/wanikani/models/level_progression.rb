# -*- encoding : utf-8 -*-
module Wanikani
  module LevelProgression
    PERMITTED_PARAMS = %w[ids updated_after page_after_id page_before_id].freeze

    class << self
      def find_by(parameters = {})
        respond(client.get('level_progressions',
                           filter(parameters)))
      end

      def find(id)
        respond(client.get("level_progressions/#{id}"))
      end

      private

      def respond(json)
        Response.new(json)
      end

      def filter(parameters)
        parameters.keep_if { |key, value| key.in?(PERMITTED_PARAMS) }
      end

      def client
        @client ||= ::Wanikani::Client.new(::Wanikani.config.to_hash)
      end
    end
  end
end
