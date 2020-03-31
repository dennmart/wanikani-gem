# -*- encoding : utf-8 -*-
module Wanikani
  module User
    class << self
      def fetch
        respond(client.get('user'))
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
