# -*- encoding : utf-8 -*-
module Wanikani
  module LevelProgression
    class << self
      def find_by(parameters = {})
        # ids
        # updated_after
        # page_after_id
        # page_before_id

        respond(client.get('level_progressions', parameters))
      end

      def find(id)
        respond(client.get("level_progressions/#{id}"))
      end

      private

      def respond(json)
        Response.new(json)
      end

      def client
        @client ||= ::Wanikani::ApiV2::Client.new(::Wanikani.config.to_hash)
      end
    end
  end
end
