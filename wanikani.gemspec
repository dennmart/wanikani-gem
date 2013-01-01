Gem::Specification.new do |s|
  s.name        = "wanikani"
  s.version     = "0.0.2"
  s.date        = "2012-12-31"
  s.summary     = "Add Japanese Kanji learning goodness to your Ruby projects!"
  s.description = "Use WaniKani's (http://www.wanikani.com/) API in your Ruby applications"
  s.authors     = ["Dennis Martinez"]
  s.email       = "dennis@dennmart.com"
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = "http://github.com/dennmart/wanikani-gem"

  s.add_runtime_dependency "rest-client", "~> 1.6"
  s.add_runtime_dependency "multi_json", "~> 1.5.0"

  s.add_development_dependency "rspec", "~> 2.12"
  s.add_development_dependency "fakeweb", "~> 1.3.0"
end
