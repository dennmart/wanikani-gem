$:.push File.expand_path("../lib", __FILE__)
require 'version'

Gem::Specification.new do |s|
  s.name        = "wanikani"
  s.version     = Wanikani::VERSION
  s.date        = "2013-11-23"
  s.summary     = "Add Japanese Kanji learning goodness to your Ruby projects!"
  s.description = "Use WaniKani's (http://www.wanikani.com/) API in your Ruby applications"
  s.authors     = ["Dennis Martinez"]
  s.email       = "dennis@dennmart.com"
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = "http://github.com/dennmart/wanikani-gem"
  s.license     = "MIT"

  s.required_ruby_version = '>= 1.9.2'

  s.add_runtime_dependency "rest-client", "~> 1.6"
  s.add_runtime_dependency "multi_json", "~> 1.8"

  s.add_development_dependency "rspec", "~> 2.14"
  s.add_development_dependency "fakeweb", "~> 1.3.0 "
end
