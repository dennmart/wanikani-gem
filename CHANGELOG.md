# WaniKani gem - Changelog

### 0.0.10

- Added `Wanikani::SRS.items_by_type` to return all items for a specific SRS type.

### 0.0.9

- Added an optional parameter to `Wanikani.valid_api_key?` to allow checking an API key without having to set `Wanikani.api_key` beforehand.
- Added a generic `Wanikani::Exception` class to define more specific exceptions when using this gem.

### 0.0.8

- Added `Wanikani::User.gravatar_url` to return the [Gravatar](http://en.gravatar.com/) image URL.
- Fixed case when using `Wanikani::Level.vocabulary` and not specifying a level - the API call returns a Hash instead of an Array.

### 0.0.7

- Added `Wanikani.valid_api_key?` method

### 0.0.6

- Added `Wanikani::User#on_vacation?` method
