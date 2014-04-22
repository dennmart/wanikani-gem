[![Build Status](https://travis-ci.org/dennmart/wanikani-gem.png)](https://travis-ci.org/dennmart/wanikani-gem) [![Code Climate](https://codeclimate.com/github/dennmart/wanikani-gem.png)](https://codeclimate.com/github/dennmart/wanikani-gem)

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

You can verify if the API is valid by using the `Wanikani.valid_api_key?` method:

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

# Alternatively, you can also specify an API key as a parameter without having to set Wanikani.api_key first.
Wanikani.valid_api_key?("ANOTHER_VALID_API_KEY")
  # => true
```

## Usage

### User Information

```ruby
require 'wanikani'

Wanikani.api_key = "YOUR_API_KEY_GOES_HERE"

Wanikani::User.information
  # => {"username"=>"crabigator", "gravatar"=>"gravatarkey", "level"=>25, "title"=>"Turtles", "about"=>"I am the almighty crabigator!", "website"=>"http://www.wanikani.com/", "twitter"=>"WaniKaniApp", "topics_count"=>1000, "posts_count"=>500, "creation_date"=>1337820000, "vacation_date"=>null}

Wanikani::User.on_vacation?
  # => false
```

### Gravatar URL

```ruby
require 'wanikani'

Wanikani.api_key = "YOUR_API_KEY_GOES_HERE"

# Non-secure default URL:
Wanikani::User.gravatar_url
  # => "http://www.gravatar.com/avatar/GRAVATAR_KEY?d=mm"

# Specifying a size:
Wanikani::User.gravatar_url(size: 250)
  # => "http://www.gravatar.com/avatar/GRAVATAR_KEY?d=mm&size=250"

# Secure URL:
Wanikani::User.gravatar_url(secure: true)
  # => "https://secure.gravatar.com/avatar/GRAVATAR_KEY?d=mm"
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
  # => {"current_level"=>25, "radicals_progress"=>5, "radicals_total"=>9, "kanji_progress"=>10, "kanji_total"=>23}
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

### Items by SRS level

```ruby
require 'wanikani'

Wanikani.api_key = "YOUR_API_KEY_GOES_HERE"

# Item type can be one of the following:
#  - burned
#  - enlighten
#  - master
#  - guru
#  - apprentice
Wanikani::SRS.items_by_type("burned")
  # => [{"character"=>"丙", "meaning"=>"dynamite", "image"=>nil, "level"=>10, "user_specific"=>{"srs"=>"burned", "unlocked_date"=>1366941766, "available_date"=>1394492400, "burned"=>true, "burned_date"=>1387518371, "meaning_correct"=>8, "meaning_incorrect"=>0, "meaning_max_streak"=>8, "meaning_current_streak"=>8, "reading_correct"=>nil, "reading_incorrect"=>nil, "reading_max_streak"=>nil, "reading_current_streak"=>nil, "meaning_note"=>nil, "user_synonyms"=>nil}, "type"=>"radical"}, ...]
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

### Critical Items

```ruby
require 'wanikani'

Wanikani.api_key = "YOUR_API_KEY_GOES_HERE"

# You can pass an optional parameter for getting critical items under a specific percentage.
Wanikani::CriticalItems.critical(90)
  # => [{"type"=>"vocabulary", "character"=>"地下", "kana"=>"ちか", "meaning"=>"underground", "level"=>6, "percentage"=>"84"}, {"type"=>"kanji", "character"=>"麦", "meaning"=>"wheat", "onyomi"=>nil, "kunyomi"=>"むぎ", "important_reading"=>"kunyomi", "level"=>5, "percentage"=>"89"}, {"type"=>"radical", "character"=>"亠", "meaning"=>"lid", "image"=>nil, "level"=>1, "percentage"=>"90"}]
```

### Radicals list by level

```ruby
require 'wanikani'

Wanikani.api_key = "YOUR_API_KEY_GOES_HERE"

# Using an Integer as the parameter will fetch the radical information for a single level.
Wanikani::Level.radicals(1)
  # => [{"character"=>"ト", "meaning"=>"toe", "image"=>nil, "level"=>1, "stats"=>{"srs"=>"burned", "unlocked_date"=>1337820726, "available_date"=>1354754764, "burned"=>true, "burned_date"=>1354754764, "meaning_correct"=>8, "meaning_incorrect"=>0, "meaning_max_streak"=>8, "meaning_current_streak"=>8, "reading_correct"=>nil, "reading_incorrect"=>nil, "reading_max_streak"=>nil, "reading_current_streak"=>nil}}, {"character"=>"八", "meaning"=>"volcano", "image"=>"http://s3.wanikani.com/images/radicals/040cbe763aa3526b2905c96062137dd3db55a38a.png", "level"=>1, "stats"=>{"srs"=>"master", "unlocked_date"=>1337820726, "available_date"=>1358751147, "burned"=>false, "burned_date"=>0, "meaning_correct"=>10, "meaning_incorrect"=>2, "meaning_max_streak"=>8, "meaning_current_streak"=>2, "reading_correct"=>nil, "reading_incorrect"=>nil, "reading_max_streak"=>nil, "reading_current_streak"=>nil}}, ... ]

# You can also use an array of Integers to get the radical information for multiple levels.
Wanikani::Level.radicals([24, 25])
  # => [{"character"=>"両", "meaning"=>"both", "image"=>nil, "level"=>25, "stats"=>nil}, {"character"=>"友", "meaning"=>"friend", "image"=>nil, "level"=>25, "stats"=>nil}, ...]
```

### Kanji list by level

```ruby
require 'wanikani'

Wanikani.api_key = "YOUR_API_KEY_GOES_HERE"

# Using an Integer as the parameter will fetch the Kanji information for a single level.
Wanikani::Level.kanji(1)
  # => [{"character"=>"一", "meaning"=>"one", "onyomi"=>"いち", "kunyomi"=>"ひと.*", "important_reading"=>"onyomi", "level"=>1, "stats"=>{"srs"=>"enlighten", "unlocked_date"=>1338820854, "available_date"=>1357346947, "burned"=>false, "burned_date"=>0, "meaning_correct"=>7, "meaning_incorrect"=>0, "meaning_max_streak"=>7, "meaning_current_streak"=>7, "reading_correct"=>7, "reading_incorrect"=>0, "reading_max_streak"=>7, "reading_current_streak"=>7}}, {"character"=>"口", "meaning"=>"mouth", "onyomi"=>"こう", "kunyomi"=>"くち", "important_reading"=>"onyomi", "level"=>1, "stats"=>{"srs"=>"guru", "unlocked_date"=>1338820840, "available_date"=>1356812196, "burned"=>false, "burned_date"=>0, "meaning_correct"=>32, "meaning_incorrect"=>1, "meaning_max_streak"=>25, "meaning_current_streak"=>7, "reading_correct"=>32, "reading_incorrect"=>21, "reading_max_streak"=>6, "reading_current_streak"=>6}}, ...]

# You can also use an array of Integers to get the Kanji information for multiple levels.
Wanikani::Level.kanji([24, 25])
  # => [{"character"=>"模", "meaning"=>"imitation", "onyomi"=>"も", "kunyomi"=>"None", "important_reading"=>"onyomi", "level"=>25, "stats"=>nil}, {"character"=>"替", "meaning"=>"replace", "onyomi"=>"たい", "kunyomi"=>"か", "important_reading"=>"kunyomi", "level"=>25, "stats"=>nil}, ...]
```

### Vocabulary list by level

```ruby
require 'wanikani'

Wanikani.api_key = "YOUR_API_KEY_GOES_HERE"

# Using an Integer as the parameter will fetch the vocabulary information for a single level.
Wanikani::Level.vocabulary(1)
  # => [{"character"=>"ふじ山", "kana"=>"ふじさん", "meaning"=>"mt fuji, mount fuji", "level"=>1, "stats"=>{"srs"=>"enlighten", "unlocked_date"=>1342432965, "available_date"=>1358369044, "burned"=>false, "burned_date"=>0, "meaning_correct"=>7, "meaning_incorrect"=>0, "meaning_max_streak"=>7, "meaning_current_streak"=>7, "reading_correct"=>7, "reading_incorrect"=>0, "reading_max_streak"=>7, "reading_current_streak"=>7}}, {"character"=>"下げる", "kana"=>"さげる", "meaning"=>"to hang, to lower", "level"=>1, "stats"=>{"srs"=>"guru", "unlocked_date"=>1342414223, "available_date"=>1357146898, "burned"=>false, "burned_date"=>0, "meaning_correct"=>19, "meaning_incorrect"=>3, "meaning_max_streak"=>9, "meaning_current_streak"=>3, "reading_correct"=>19, "reading_incorrect"=>2, "reading_max_streak"=>11, "reading_current_streak"=>7}}, ...]

# You can also use an array of Integers to get the vocabulary information for multiple levels.
Wanikani::Level.vocabulary([24, 25])
  # => [{"character"=>"後輩", "kana"=>"こうはい", "meaning"=>"junior, one's junior", "level"=>25, "stats"=>nil}, {"character"=>"年輩", "kana"=>"ねんぱい", "meaning"=>"elderly person, old person", "level"=>25, "stats"=>nil}, ...]
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
