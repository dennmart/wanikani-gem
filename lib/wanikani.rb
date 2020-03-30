# -*- encoding : utf-8 -*-
require 'wanikani/client'
require 'wanikani/api_v2/client'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

module Wanikani
  DEFAULT_API_VERSION = "v2"
  VALID_API_VERSIONS = %w(v1 v1.1 v1.2 v1.3 v1.4 v2)

  class InvalidKey < Exception; end
  class Exception < Exception; end
end
