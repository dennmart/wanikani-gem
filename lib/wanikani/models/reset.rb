# -*- encoding : utf-8 -*-
module Wanikani
  module Reset
    extend Wanikani::Shared

    PERMITTED_PARAMS = %w[ids assignment_ids subject_ids updated_after page_after_id page_before_id].freeze

    def self.find_by(parameters = {})
      respond(client.get('resets', parameters))
    end

    def self.find(id)
      respond(client.get("resets/#{id}"))
    end

    def self.permitted_params
      PERMITTED_PARAMS
    end
  end
end
