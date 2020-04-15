# -*- encoding : utf-8 -*-
module Wanikani
  module Assignment
    extend Wanikani::Shared

    PERMITTED_PARAMS = %w[available_after available_before burned hidden ids immediately_available_for_lessons immediately_available_for_review in_review levels passed srs_stages started subject_ids subject_types unlocked updated_after page_after_id page_before_id].freeze

    def self.permitted_params
      PERMITTED_PARAMS
    end

    def self.find_all
      find_by
    end

    def self.find_by(parameters = {})
      respond(client.get('assignments', filter(parameters)))
    end

    def self.find(id)
      respond(client.get("assignments/#{id}"))
    end
  end
end
