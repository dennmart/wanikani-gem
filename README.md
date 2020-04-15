[![Build Status](https://travis-ci.org/dennmart/wanikani-gem.png)](https://travis-ci.org/dennmart/wanikani-gem) [![Code Climate](https://codeclimate.com/github/dennmart/wanikani-gem.png)](https://codeclimate.com/github/dennmart/wanikani-gem)

Want to get your Japanese Kanji studies in your Ruby? This gem uses [WaniKani's API](https://docs.api.wanikani.com) so you can hook it into your Ruby projects.

## Installation
```
$ gem install wanikani
```

## Usage

To use the WaniKani gem, you need to set up client, using the API key from your account. The API key can be found in your [account settings](https://www.wanikani.com/settings/personal_access_tokens).

```ruby
require 'wanikani'

Wanikani.configure do |config|
  config.api_key = "YOUR_API_KEY"
end

response = Wanikani::Subject.find_all
@subjects = response.data

```

By default, the gem uses the API version 2 with revision 20170710.


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

### Endpoints

The gem supports all endpoints documented in [WaniKani's API](https://docs.api.wanikani.com).

#### Example: User Information

Some endpoints like `User`, `Summary` and `SrsStages` return only a
single object.

```ruby
require 'wanikani'

response = Wanikani::User.fetch
# Response storing the meta data of the response.
# To access the payload, access the field `data`. It'll return a Hash

@user = response.data
  # => { "id": "5a6a5234-a392-4a87-8f3f-33342afe8a42", "username": "crabigator", "level": 25, "profile_url": "https://www.wanikani.com/users/crabigator", "started_at": "2012-05-11T00:52:18.958466Z", "current_vacation_started_at": null, "subscription": { "active": true, "type": "recurring", "max_level_granted": 60, "period_ends_at": "2018-12-11T13:32:19.485748Z" }, "preferences": { "default_voice_actor_id": 1, "lessons_autoplay_audio": false, "lessons_batch_size": 5, "lessons_presentation_order": "ascending_level_then_subject", "reviews_autoplay_audio": false, "reviews_display_srs_indicator": true } }

```

#### Example: Subjects

Most endpoints can return either a specified object or a collection of objects.

```ruby
require 'wanikani'

response = Wanikani::Subject.find_all

# or filter by giving a parameter
response = Wanikani::Subject.find_by(hidden: false)

# Response storing the meta data of the response.
# To access the payload, access the field `data`. It'll return an Array for collections

response.type
  # => 'collection'

@subjects = response.data
  # => [ { "id": 440, "object": "kanji", "url": "https://api.wanikani.com/v2/subjects/440", "data_updated_at": "2018-03-29T23:14:30.805034Z", "data": {  "created_at": "2012-02-27T19:55:19.000000Z",  "level": 1,  "slug": "一",  "hidden_at": null,  "document_url": "https://www.wanikani.com/kanji/%E4%B8%80",  "characters": "一",  "meanings": [  {  "meaning": "One",  "primary": true,  "accepted_answer": true  }  ],  "readings": [  {  "type": "onyomi",  "primary": true,  "accepted_answer": true,  "reading": "いち"  },  {  "type": "kunyomi",  "primary": false,  "accepted_answer": false,  "reading": "ひと"  },  {  "type": "nanori",  "primary": false,  "accepted_answer": false,  "reading": "かず"  }  ],  "component_subject_ids": [  1  ],  "amalgamation_subject_ids": [  56,  88,  91  ],  "visually_similar_subject_ids": [],  "meaning_mnemonic": "Lying on the <radical>ground</radical> is something that looks just like the ground, the number <kanji>One</kanji>. Why is this One lying down? It's been shot by the number two. It's lying there, bleeding out and dying. The number One doesn't have long to live.",  "meaning_hint": "To remember the meaning of <kanji>One</kanji>, imagine yourself there at the scene of the crime. You grab <kanji>One</kanji> in your arms, trying to prop it up, trying to hear its last words. Instead, it just splatters some blood on your face. \"Who did this to you?\" you ask. The number One points weakly, and you see number Two running off into an alleyway. He's always been jealous of number One and knows he can be number one now that he's taken the real number one out.",  "reading_mnemonic": "As you're sitting there next to <kanji>One</kanji>, holding him up, you start feeling a weird sensation all over your skin. From the wound comes a fine powder (obviously coming from the special bullet used to kill One) that causes the person it touches to get extremely <reading>itchy</reading> (いち)",  "reading_hint": "Make sure you feel the ridiculously <reading>itchy</reading> sensation covering your body. It climbs from your hands, where you're holding the number <kanji>One</kanji> up, and then goes through your arms, crawls up your neck, goes down your body, and then covers everything. It becomes uncontrollable, and you're scratching everywhere, writhing on the ground. It's so itchy that it's the most painful thing you've ever experienced (you should imagine this vividly, so you remember the reading of this kanji).",  "lesson_position": 2 } } ]

```

Or if you want to access a single object.

```ruby
require 'wanikani'

response = Wanikani::Subject.find(440)

# Response storing the meta data of the response.
# To access the payload, access the field `data`. It'll return a Hash

response.type
  # => 'kanji'

@kanji = response.data
  # => {  "created_at": "2012-02-27T19:55:19.000000Z",  "level": 1,  "slug": "一",  "hidden_at": null,  "document_url": "https://www.wanikani.com/kanji/%E4%B8%80",  "characters": "一",  "meanings": [  {  "meaning": "One",  "primary": true,  "accepted_answer": true  }  ],  "readings": [  {  "type": "onyomi",  "primary": true,  "accepted_answer": true,  "reading": "いち"  },  {  "type": "kunyomi",  "primary": false,  "accepted_answer": false,  "reading": "ひと"  },  {  "type": "nanori",  "primary": false,  "accepted_answer": false,  "reading": "かず"  }  ],  "component_subject_ids": [  1  ],  "amalgamation_subject_ids": [  56,  88,  91  ],  "visually_similar_subject_ids": [],  "meaning_mnemonic": "Lying on the <radical>ground</radical> is something that looks just like the ground, the number <kanji>One</kanji>. Why is this One lying down? It's been shot by the number two. It's lying there, bleeding out and dying. The number One doesn't have long to live.",  "meaning_hint": "To remember the meaning of <kanji>One</kanji>, imagine yourself there at the scene of the crime. You grab <kanji>One</kanji> in your arms, trying to prop it up, trying to hear its last words. Instead, it just splatters some blood on your face. \"Who did this to you?\" you ask. The number One points weakly, and you see number Two running off into an alleyway. He's always been jealous of number One and knows he can be number one now that he's taken the real number one out.",  "reading_mnemonic": "As you're sitting there next to <kanji>One</kanji>, holding him up, you start feeling a weird sensation all over your skin. From the wound comes a fine powder (obviously coming from the special bullet used to kill One) that causes the person it touches to get extremely <reading>itchy</reading> (いち)",  "reading_hint": "Make sure you feel the ridiculously <reading>itchy</reading> sensation covering your body. It climbs from your hands, where you're holding the number <kanji>One</kanji> up, and then goes through your arms, crawls up your neck, goes down your body, and then covers everything. It becomes uncontrollable, and you're scratching everywhere, writhing on the ground. It's so itchy that it's the most painful thing you've ever experienced (you should imagine this vividly, so you remember the reading of this kanji).",  "lesson_position": 2 }
```

Endpoints returning collections may have limits to the number of elements
they return. The API supports access via pagination, however this needs to
be implemented outside of the gem.

Please see the [Wanikani's API](https://docs.api.wanikani.com/20170710/#pagination)
for more details.

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
