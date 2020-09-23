# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wanikani/version'

Gem::Specification.new do |s|
  s.name        = "wanikani"
  s.version     = Wanikani::VERSION
  s.summary     = "Add Japanese Kanji learning goodness to your Ruby projects!"
  s.description = "Use WaniKani's (https://www.wanikani.com/) API in your Ruby applications"
  s.authors     = ["Dennis Martinez"]
  s.email       = "dennis@dennmart.com"
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = "https://github.com/dennmart/wanikani-gem"
  s.license     = "MIT"

  s.required_ruby_version = ">= 2.4"

  s.add_runtime_dependency "faraday", "~> 0.12"
  s.add_runtime_dependency "faraday_middleware", "~> 0.12"

  s.add_development_dependency "rspec", "~> 3.6"
  s.add_development_dependency "webmock", "~> 3.0"

  s.post_install_message = <<-MSG
    Version 3.0 of the wanikani gem introduces many breaking changes in support of Wanikani API 2.0.
    Please view the README for more information: https://github.com/dennmart/wanikani-gem
  MSG
end
