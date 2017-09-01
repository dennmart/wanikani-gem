# -*- encoding : utf-8 -*-
require 'wanikani/client'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

module Wanikani
  class InvalidKey < Exception; end
  class Exception < Exception; end
end
