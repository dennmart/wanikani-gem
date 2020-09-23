# -*- encoding : utf-8 -*-
module Wanikani
  module Shared
    def respond(json)
      Response.new(json)
    end

    def permitted_params
      raise NotImplementedError
    end

    def filter(parameters)
      parameters.keep_if { |key, value| permitted_params.include?(key.to_s) }
    end

    def client
      @client ||= ::Wanikani::Client.new(::Wanikani.config.to_hash)
    end
  end
end
