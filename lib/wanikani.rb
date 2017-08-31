# -*- encoding : utf-8 -*-
require 'faraday'
require 'faraday_middleware'

require 'wanikani/user'
require 'wanikani/study_queue'
require 'wanikani/level'
require 'wanikani/srs'
require 'wanikani/recent_unlocks'
require 'wanikani/critical_items'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

module Wanikani
  class InvalidKey < Exception; end
  class Exception < Exception; end

  class Client
    API_ENDPOINT = "https://www.wanikani.com"
    DEFAULT_API_VERSION = "v1.4"
    VALID_API_VERSIONS = %w(v1 v1.1 v1.2 v1.3 v1.4)

    include Wanikani::User
    include Wanikani::StudyQueue
    include Wanikani::Level
    include Wanikani::SRS
    include Wanikani::RecentUnlocks
    include Wanikani::CriticalItems

    attr_accessor :api_key, :api_version

    def initialize(options = {})
      raise ArgumentError, "You must specify a Wanikani API key before querying the API." if options[:api_key].nil? || options[:api_key].empty?
      raise ArgumentError, "API version should be one of the following: #{VALID_API_VERSIONS.join(', ')}." unless VALID_API_VERSIONS.include?(options[:api_version]) || options[:api_version].nil?

      @api_key = options[:api_key]
      @api_version = options[:api_version] ||= DEFAULT_API_VERSION
    end

    def valid_api_key?(api_key = nil)
      api_key ||= @api_key
      return false if api_key.empty?

      res = client.get("/api/#{@api_version}/user/#{api_key}/user-information")

      return false if !res.success? || res.body.has_key?("error")
      return true
    end

    private

    def client
      Faraday.new(url: API_ENDPOINT) do |conn|
        conn.response :json, :content_type => /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end

    def api_response(resource, optional_arg = nil)
      raise ArgumentError, "You must define a resource to query Wanikani" if resource.nil? || resource.empty?

      begin
        res = client.get("/api/#{@api_version}/user/#{@api_key}/#{resource}/#{optional_arg}")

        if !res.success? || res.body.has_key?("error")
          raise_exception(res)
        else
          return res.body
        end
      rescue => error
        raise Exception, "There was an error: #{error.message}"
      end
    end

    def raise_exception(response)
      raise Wanikani::InvalidKey, "The API key used for this request is invalid." and return if response.status == 401

      message = if response.body.is_a?(Hash) and response.body.has_key?("error")
                  response.body["error"]["message"]
                else
                  "Status code: #{response.status}"
                end
      raise Wanikani::Exception, "There was an error fetching the data from Wanikani (#{message})"
    end
  end
end


#module Wanikani
  #API_ENDPOINT = "https://www.wanikani.com"
  #DEFAULT_API_VERSION = "v1.4"
  #VALID_API_VERSIONS = %w(v1 v1.1 v1.2 v1.3 v1.4)

  #def self.api_key=(api_key)
    #@api_key = api_key
  #end

  #def self.api_key
    #@api_key
  #end

  #def self.api_version=(api_version)
    #raise ArgumentError, "API version should be one of the following: #{VALID_API_VERSIONS.join(', ')}." unless VALID_API_VERSIONS.include?(api_version) || api_version.nil?
    #@api_version = api_version
  #end

  #def self.api_version
    #@api_version ||= DEFAULT_API_VERSION
  #end

  #def self.api_response(resource, optional_arg = nil)
    #raise ArgumentError, "You must define a resource to query Wanikani" if resource.nil? || resource.empty?
    #raise ArgumentError, "You must set your Wanikani API key before querying the API" if Wanikani.api_key.nil? || Wanikani.api_key.empty?

    #begin
      #res = client.get("/api/#{Wanikani.api_version}/user/#{Wanikani.api_key}/#{resource}/#{optional_arg}")

      #if !res.success? || res.body.has_key?("error")
        #self.raise_exception(res)
      #else
        #return res.body
      #end
    #rescue => error
      #raise Exception, "There was an error: #{error.message}"
    #end
  #end

  #def self.valid_api_key?(api_key = nil)
    #api_key ||= Wanikani.api_key
    #return false if api_key.nil? || api_key.empty?

    #res = client.get("/api/#{Wanikani.api_version}/user/#{api_key}/user-information")

    #return false if !res.success? || res.body.has_key?("error")
    #return true
  #end

  #private

  #def self.client
    #Faraday.new(url: Wanikani::API_ENDPOINT) do |conn|
      #conn.response :json, :content_type => /\bjson$/
      #conn.adapter Faraday.default_adapter
    #end
  #end

  #def self.raise_exception(response)
    #raise Wanikani::InvalidKey, "The API key used for this request is invalid." and return if response.status == 401

    #message = if response.body.is_a?(Hash) and response.body.has_key?("error")
                #response.body["error"]["message"]
              #else
                #"Status code: #{response.status}"
              #end
    #raise Wanikani::Exception, "There was an error fetching the data from Wanikani (#{message})"
  #end
#end
