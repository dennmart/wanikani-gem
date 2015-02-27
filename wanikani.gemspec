# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wanikani/version'

Gem::Specification.new do |s|
  s.name        = "wanikani"
  s.version     = Wanikani::VERSION
  s.date        = "2015-02-27"
  s.summary     = "Add Japanese Kanji learning goodness to your Ruby projects!"
  s.description = "Use WaniKani's (https://www.wanikani.com/) API in your Ruby applications"
  s.authors     = ["Dennis Martinez"]
  s.email       = "dennis@dennmart.com"
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = "https://github.com/dennmart/wanikani-gem"
  s.license     = "MIT"

  s.required_ruby_version = '>= 1.9.2'

  s.add_runtime_dependency "rest-client", "~> 1.7"
  s.add_runtime_dependency "multi_json", "~> 1.10"

  s.add_development_dependency "rspec", "~> 3.1"
  s.add_development_dependency "webmock", "~> 1.2"
end
