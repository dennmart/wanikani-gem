# -*- encoding : utf-8 -*-
module Wanikani
  module SrsStages
    extend Wanikani::Shared

    def self.fetch
      respond(client.get('srs_stages'))
    end
  end
end
