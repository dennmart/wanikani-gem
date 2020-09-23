# -*- encoding : utf-8 -*-
module Wanikani
  module User
    extend Wanikani::Shared

    def self.fetch
      respond(client.get('user'))
    end
  end
end
