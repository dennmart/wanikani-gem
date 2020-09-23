# -*- encoding : utf-8 -*-
module Wanikani
  class Response
    attr_reader :response_data

    def initialize(response_data)
      @response_data = response_data
    end

    def data
      response_data['data']
    end

    def id
      response_data['id']
    end

    def object
      response_data['object']
    end

    def data_updated_at
      response_data['data_updated_at']
    end

    def per_page
      response_data['pages']['per_page']
    end

    def total_count
      response_data['total_count']
    end
  end
end
