# -*- encoding : utf-8 -*-
module Wanikani
  module Subject
    class << self
      def find_by(parameters = {})
        # ids:
        # types:
        # slugs:
        # levels:
        # hidden:
        # updated_after:
        # page_after_id
        # page_before_id

        respond(client.get('subjects', parameters))
      end


      def find(id)
        respond(client.get("subjects/#{id}"))
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
