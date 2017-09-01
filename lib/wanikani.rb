# -*- encoding : utf-8 -*-
require 'wanikani/client'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

module Wanikani
  API_ENDPOINT = "https://www.wanikani.com"
  DEFAULT_API_VERSION = "v1.4"
  VALID_API_VERSIONS = %w(v1 v1.1 v1.2 v1.3 v1.4)

  class InvalidKey < Exception; end
  class Exception < Exception; end
end
