require 'wanikani'
require 'fakeweb'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = 'random'
  config.before(:each) { Wanikani.api_key = "WANIKANI-API-KEY" }
end

FakeWeb.allow_net_connect = false
