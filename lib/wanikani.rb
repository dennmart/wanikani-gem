# -*- encoding : utf-8 -*-
require 'faraday'
require 'faraday_middleware'

require 'wanikani/user'
require 'wanikani/study_queue'
require 'wanikani/level'
require 'wanikani/srs'
require 'wanikani/recent_unlocks'
require 'wanikani/critical_items'
require 'wanikani/exceptions'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

module Wanikani
  API_ENDPOINT = "https://www.wanikani.com"
  DEFAULT_API_VERSION = "v1.4"
  VALID_API_VERSIONS = %w(v1 v1.1 v1.2 v1.3 v1.4)

  def self.api_key=(api_key)
    @api_key = api_key
  end

  def self.api_key
    @api_key
  end

  def self.api_version=(api_version)
    raise ArgumentError, "API version should be one of the following: #{VALID_API_VERSIONS.join(', ')}." unless VALID_API_VERSIONS.include?(api_version) || api_version.nil?
    @api_version = api_version
  end

  def self.api_version
    @api_version ||= DEFAULT_API_VERSION
  end

  def self.api_response(resource, optional_arg = nil)
    raise ArgumentError, "You must define a resource to query Wanikani" if resource.nil? || resource.empty?
    raise ArgumentError, "You must set your Wanikani API key before querying the API" if Wanikani.api_key.nil? || Wanikani.api_key.empty?

    begin
      res = client.get("/api/#{Wanikani.api_version}/user/#{Wanikani.api_key}/#{resource}/#{optional_arg}")

      if res.body.has_key?("error")
        self.raise_exception(res.body["error"]["message"])
      else
        return res.body
      end
    rescue => error
      self.raise_exception(error.message)
    end
  end

  def self.valid_api_key?(api_key = nil)
    api_key ||= Wanikani.api_key
    return false if api_key.nil? || api_key.empty?

    res = client.get("/api/#{Wanikani.api_version}/user/#{api_key}/user-information")
    !res.body.has_key?("error")
  end

  private

  def self.client
    Faraday.new(url: Wanikani::API_ENDPOINT) do |conn|
      conn.response :json, :content_type => /\bjson$/
      conn.adapter Faraday.default_adapter
    end
  end

  def self.raise_exception(message)
    raise Wanikani::Exception, "There was an error fetching the data from Wanikani (#{message})"
  end
end
