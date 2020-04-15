[![Build Status](https://travis-ci.org/dennmart/wanikani-gem.png)](https://travis-ci.org/dennmart/wanikani-gem) [![Code Climate](https://codeclimate.com/github/dennmart/wanikani-gem.png)](https://codeclimate.com/github/dennmart/wanikani-gem)

Want to get your Japanese Kanji studies in your Ruby? This gem uses [WaniKani's API](http://www.wanikani.com/api) so you can hook it into your Ruby projects.

## Installation
```
$ gem install wanikani
```

## Usage

To use the WaniKani gem, you need to set up client, using the API key from your account. The API key can be found in your [account settings](https://www.wanikani.com/settings/personal_access_tokens).

```ruby
require 'wanikani'

@client = Wanikani::Client.new(api_key: "YOUR_API_KEY")
```

By default, the gem uses the old API version (currently `v1.4`). You can use the current API version 2 by choosing the v2 client.


```ruby
require 'wanikani'

Wanikani.configure do |config|
  config.api_key = "YOUR_API_KEY"
end

response = Wanikani::Subject.find_by
@subjects = response.data

```

For the moment, the gem only supports Wanikani-API V2 current revision 20170710.

### Check if an API key is valid

```ruby
require 'wanikani'

# Using an invalid API Key:
@client = Wanikani::Client.new(api_key: "INVALID_API_KEY")
@client.valid_api_key?
  # => false

# Using a valid API key:
@client = Wanikani::Client.new(api_key: "VALID_API_KEY")
@client.valid_api_key?
  # => true

# Alternatively, you can check the validity of any
# API key without setting up a client:
Wanikani::Client.valid_api_key?("VALID_API_KEY")
  # => true
```

### User Information

```ruby
require 'wanikani'

@client = Wanikani::Client.new(api_key: "YOUR_API_KEY")

@client.user_information
  # => {"username"=>"crabigator", "gravatar"=>"gravatarkey", "level"=>25, "title"=>"Turtles", "about"=>"I am the almighty crabigator!", "website"=>"http://www.wanikani.com/", "twitter"=>"WaniKaniApp", "topics_count"=>1000, "posts_count"=>500, "creation_date"=>1337820000, "vacation_date"=>null}

@client.on_vacation?
  # => false

# Get the full WaniKani API response.
@client.full_user_response
```


*References to Gravatar were removed in API V2 and gravatar_url
is not available anymore.*


## Handling API Request Exceptions

The gem will handle API request exceptions with the following exception classes:

- `Wanikani::InvalidKey`: The API response will return a 401 status code indicating that the API key used is not valid. The gem will throw this exception so you can catch errors where the API key is not valid.
- `Wanikani::Exception`: Any API responses with a non-successful (20x) status code **or** with an `error` key in the body will throw this exception, including additional information on the status code (if not a 20x status code) or the message in the body (if the `error` key is present in the response).

## API Version 1

Support for Wanikani API version 1 has been removed in Version 3.0 of this gem.
The API is at the end of its lifecycle and will be shutdown by September 2020.
Keep using Version 2.0 of this gem, if you need support for the old API.

## Contributing

I'll be super-happy if you guys help giving back! If you want to do some hacking on the WaniKani gem, this is a good guideline to get started:

* Fork the repo on GitHub
* Create a branch on your clone that will contain your changes
* Hack away on your branch
* Add tests in the `/spec` directory relating to your changes
* Make sure all specs still pass
* If you're adding new functionality, make sure to update `README.md`
* Push the branch to GitHub
* Send me a pull request for your branch
