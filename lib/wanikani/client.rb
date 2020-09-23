# -*- encoding : utf-8 -*-
require 'faraday'
require 'faraday_middleware'

module Wanikani
  class Client
    API_ENDPOINT = "https://api.wanikani.com"

    attr_accessor :api_key, :api_revision

    # Initialize a client which will be used to communicate with WaniKani.
    #
    # @param options [Hash] the API key (required) and API version (optional)
    #   used to communicate with the WaniKani API.
    # @return [Wanikani::Client] an instance of Wanikani::Client.
    def initialize(options = {})
      raise ArgumentError, "You must specify a WaniKani API key before querying the API." if options[:api_key].nil? || options[:api_key].empty?
      raise ArgumentError, "API revision should be one of the following: #{Wanikani::VALID_API_REVISIONS.join(', ')}." unless Wanikani::VALID_API_REVISIONS.include?(options[:api_revision]) || options[:api_revision].nil?

      @api_key = options[:api_key]
      @api_revision = options[:api_revision] ||= Wanikani::DEFAULT_API_REVISION

    end

    # Verifies if the client's API key is valid by checking WaniKani's API.
    #
    # @param api_key [String] the API key to validate in WaniKani.
    # @return [Boolean] whether the API key is valid.
    def valid_api_key?(api_key = nil)
      api_key ||= @api_key
      return false if api_key.empty?

      res = client.get("/v2/user/")

      return false if !res.success? || res.body.has_key?("error")
      return true
    end

    # Verifies if the specified API key is valid by checking WaniKani's API.
    #
    # @param api_key [String] the API key to validate in WaniKani.
    # @return [Boolean] whether the API key is valid.
    def self.valid_api_key?(api_key = nil)
      raise ArgumentError, "You must specify a WaniKani API key before querying the API." if api_key.nil? || api_key.empty?

      @client = Wanikani::Client.new(api_key: api_key)
      return @client.valid_api_key?
    end

    # API endpoint at WaniKani
    #
    # @return [String] URL of endpoint
    def api_endpoint
      API_ENDPOINT
    end

    # Contacts the WaniKani API and returns the data specified.
    #
    # @param resource [String] the resource to access.
    # @param parameters [Hash] optional arguments for the specified resource.
    # @return [Hash] the parsed API response.
    def get(resource, parameters = nil)
      raise ArgumentError, "You must define a resource to query WaniKani" if resource.nil? || resource.empty?

      begin
        res = client.get("/v2/#{resource}", parameters)

        if !res.success? || res.body.has_key?("error")
          raise_exception(res)
        else
          return res.body
        end
      rescue => error
        raise Exception, "There was an error: #{error.message}"
      end
    end

    private

    # Sets up the HTTP client for communicating with the WaniKani API.
    #
    # @return [Faraday::Connection] the HTTP client to communicate with the
    #   WaniKani API.
    def client
      Faraday.new(url: api_endpoint, :headers => headers) do |conn|
        conn.response :json, :content_type => /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end

    def headers
      {
        'Content-Type' => 'application/json',
        'Wanikani-Revision' => api_revision,
        'Authorization' => "Bearer #{api_key}"
}
    end


    # Handles exceptions according to the API response.
    #
    # @param response [Hash] the parsed API response from WaniKani's API.
    def raise_exception(response)
      raise Wanikani::InvalidKey, "The API key used for this request is invalid." and return if response.status == 401

      message = if response.body.is_a?(Hash) and response.body.has_key?("error")
                  response.body["error"]
                else
                  "Status code: #{response.status}"
                end
      raise Wanikani::Exception, "There was an error fetching the data from WaniKani (#{message})"
    end
  end
end
