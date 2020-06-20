# -*- encoding : utf-8 -*-
module Wanikani
  module SpacedRepetitionSystem
    extend Wanikani::Shared

    PERMITTED_PARAMS = %w[ids updated_after].freeze

    def self.find_all
      find_by
    end

    def self.find_by(parameters = {})
      respond(client.get('spaced_repetition_systems',
                         filter(parameters)))
    end

    def self.find(id)
      respond(client.get("spaced_repetition_systems/#{id}"))
    end

    def self.permitted_params
      PERMITTED_PARAMS
    end
  end
end
