# -*- encoding : utf-8 -*-
module Wanikani
  module ReviewStatistic
    extend Wanikani::Shared

    PERMITTED_PARAMS = %w[ids hidden percentages_greater_than percentages_less_than subject_ids subject_types updated_after page_after_id page_before_id].freeze

    def self.find_all
      find_by
    end

    def self.find_by(parameters = {})
      respond(client.get('review_statistics', parameters))
    end

    def self.find(id)
      respond(client.get("review_statistics/#{id}"))
    end

    def self.permitted_params
      PERMITTED_PARAMS
    end
  end
end
