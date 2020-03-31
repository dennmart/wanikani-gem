# -*- encoding : utf-8 -*-
require 'wanikani/client'
require 'wanikani/response'
require 'wanikani/configuration'
require 'wanikani/api_v2/client'
require 'wanikani/models/assignment'
require 'wanikani/models/level_progression'
require 'wanikani/models/reset'
require 'wanikani/models/review'
require 'wanikani/models/review_statistic'
require 'wanikani/models/srs_stages'
require 'wanikani/models/study_material'
require 'wanikani/models/subject'
require 'wanikani/models/summary'
require 'wanikani/models/voice_actor'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

module Wanikani
  DEFAULT_API_VERSION = "v2"
  VALID_API_VERSIONS = %w(v1 v1.1 v1.2 v1.3 v1.4 v2)

  class InvalidKey < Exception; end
  class Exception < Exception; end

  DEFAULT_CONFIG = {
    api_version: DEFAULT_API_VERSION
  }

  def self.configure
    yield @config ||= Wanikani::Configuration.new(DEFAULT_CONFIG)
  end

  # global settings
  def self.config
    @config ||= Wanikani::Configuration.new(DEFAULT_CONFIG)
  end
end
