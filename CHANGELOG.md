# WaniKani gem - Changelog

### 1.4.1
- Handle errors when the WaniKani API returns an unsuccessful API response with a blank body.

### 1.4
- All changes were to the underlying code - no functionality has been changed.
- Switched HTTP library from RestClient to Faraday.
- Updated any outdated gems used in the library (for runtime and development dependencies).

### 1.3
- Changed default API version to v1.4.


### 1.2
- Changed default API version to v1.3.

### 1.1
- Added `full_response` method to available classes that returns a hash with the full response from the WaniKani API call.

### 1.0
- Version 1.0!
- Added `Wanikani.api_version` to be able to select a specific API version to use.
- Use HTTPS for all API requests.

### 0.10

- Added `Wanikani::SRS.items_by_type` to return all items for a specific SRS type.
- Slight change in versioning, in preparation for that all-so-important 1.0 release!

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
