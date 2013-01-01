[![Build Status](https://travis-ci.org/dennmart/wanikani-gem.png)](https://travis-ci.org/dennmart/wanikani-gem)

Want to get your Japanese Kanji studies in your Ruby? This gem uses [WaniKani's API](http://www.wanikani.com/api) so you can hook it into your Ruby projects.

## Installation
```
$ gem install wanikani
```

## API Key

Before doing anything, you need to set up the WaniKani API key from your account. The key can be found in your [account settings](http://www.wanikani.com/account).

```ruby
Wanikani.api_key = "YOUR_API_KEY_GOES_HERE"
```

You need to set your API key before attempting to use any of the gem's methods. If you're using the gem in Rails, you can set it as an initializer (for example, under `config/initializers/wanikani.rb`).

## Usage

### User Information

```ruby
require 'wanikani'

Wanikani.api_key = "YOUR_API_KEY_GOES_HERE"

Wanikani::User.information
  # => {"username"=>"crabigator", "gravatar"=>"gravatarkey", "level"=>25, "title"=>"Turtles", "about"=>"I am the almighty crabigator!", "website"=>"http://www.wanikani.com/", "twitter"=>"WaniKaniApp", "topics_count"=>1000, "posts_count"=>500, "creation_date"=>1337820000}
```

### Study Queue

```ruby
require 'wanikani'

Wanikani.api_key = "YOUR_API_KEY_GOES_HERE"

Wanikani::StudyQueue.queue
  # => {"lessons_available"=>77, "reviews_available"=>5, "next_review_date"=>1355893492, "reviews_available_next_hour"=>6, "reviews_available_next_day"=>24}

Wanikani::StudyQueue.lessons_available?
  # => true

Wanikani::StudyQueue.reviews_available?
  # => true
```

### Level Progression

```ruby
require 'wanikani'

Wanikani.api_key = "YOUR_API_KEY_GOES_HERE"

Wanikani::Level.progression
  # => {"radicals_progress"=>5, "radicals_total"=>9, "kanji_progress"=>10, "kanji_total"=>23}
```

### SRS Distribution

```ruby
require 'wanikani'

Wanikani.api_key = "YOUR_API_KEY_GOES_HERE"

Wanikani::SRS.distribution
  # => {"apprentice"=>{"radicals"=>1, "kanji"=>4, "vocabulary"=>12, "total"=>17}, "guru"=>{"radicals"=>24, "kanji"=>75, "vocabulary"=>181, "total"=>280}, "master"=>{"radicals"=>38, "kanji"=>37, "vocabulary"=>82, "total"=>157}, "enlighten"=>{"radicals"=>82, "kanji"=>93, "vocabulary"=>189, "total"=>364}, "burned"=>{"radicals"=>19, "kanji"=>0, "vocabulary"=>0, "total"=>19}}

# You can alternatively pass an SRS level as a parameter to get only that information.
Wanikani::SRS.distribution("apprentice")
  # => {"radicals"=>1, "kanji"=>4, "vocabulary"=>12, "total"=>17}
```

### Recent Unlocks

```ruby
require 'wanikani'

Wanikani.api_key = "YOUR_API_KEY_GOES_HERE"

# You can pass an optional parameter for limiting the number of items returned (default: 10).
Wanikani::RecentUnlocks.list(3)
  # => [{"type"=>"vocabulary", "character"=>"首", "kana"=>"くび", "meaning"=>"neck", "level"=>6, "unlocked_date"=>1355879555}, {"type"=>"kanji", "character"=>"辺", "meaning"=>"area", "onyomi"=>"へん", "kunyomi"=>"あたり", "important_reading"=>"onyomi", "level"=>7, "unlocked_date"=>1355762469}, {"type"=>"radical", "character"=>"鳥", "meaning"=>"bird", "image"=>nil, "level"=>7, "unlocked_date"=>1355759947}]

Wanikani::RecentUnlocks.radicals(1)
  # => [{"type"=>"radical", "character"=>"鳥", "meaning"=>"bird", "image"=>nil, "level"=>7, "unlocked_date"=>1355759947}]

Wanikani::RecentUnlocks.vocabulary(1)
  # => [{"type"=>"vocabulary", "character"=>"首", "kana"=>"くび", "meaning"=>"neck", "level"=>6, "unlocked_date"=>1355879555}]

Wanikani::RecentUnlocks.kanji(1)
  # => [{"type"=>"kanji", "character"=>"辺", "meaning"=>"area", "onyomi"=>"へん", "kunyomi"=>"あたり", "important_reading"=>"onyomi", "level"=>7, "unlocked_date"=>1355762469}]
```

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
