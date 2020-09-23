# -*- encoding : utf-8 -*-
module Wanikani
  module Summary
    extend Wanikani::Shared

    def self.fetch
      respond(client.get('summary'))
    end
  end
end
