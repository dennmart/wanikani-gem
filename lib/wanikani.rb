# -*- encoding : utf-8 -*-
require 'wanikani/client'
require 'wanikani/response'
require 'wanikani/configuration'
require 'wanikani/models/shared'
require 'wanikani/models/assignment'
require 'wanikani/models/level_progression'
require 'wanikani/models/reset'
require 'wanikani/models/review'
require 'wanikani/models/review_statistic'
require 'wanikani/models/spaced_repetition_system'
require 'wanikani/models/study_material'
require 'wanikani/models/subject'
require 'wanikani/models/summary'
require 'wanikani/models/user'
require 'wanikani/models/voice_actor'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

module Wanikani
  DEFAULT_API_REVISION = '20170710'
  VALID_API_REVISIONS = %w(20170710)

  class InvalidKey < Exception; end
  class Exception < Exception; end

  DEFAULT_CONFIG = {
    api_revision: DEFAULT_API_REVISION
  }

  def self.configure
    yield @config ||= Wanikani::Configuration.new(DEFAULT_CONFIG)
  end

  # global settings
  def self.config
    @config ||= Wanikani::Configuration.new(DEFAULT_CONFIG)
  end
end
