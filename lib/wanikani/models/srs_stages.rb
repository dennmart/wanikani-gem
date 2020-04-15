# -*- encoding : utf-8 -*-
module Wanikani
  module SrsStages
    class << self
      def fetch
        respond(client.get('srs_stages'))
      end

      private

      def respond(json)
        Response.new(json)
      end

      def client
        @client ||= ::Wanikani::Client.new(::Wanikani.config.to_hash)
      end
    end
  end
end
