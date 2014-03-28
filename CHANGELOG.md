# WaniKani gem - Changelog

### 0.0.7

- Added `Wanikani.valid_api_key?` method

```ruby
require 'wanikani'

# Using an invalid API Key:
Wanikani.api_key = "INVALID_API_KEY"
Wanikani.valid_api_key?
  # => false

# Using a valid API key:
Wanikani.api_key = "VALID_API_KEY"
Wanikani.valid_api_key?
  # => true
```

### 0.0.6

- Added `Wanikani::User#on_vacation?` method
