# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Wanikani::Level do
  describe ".progression" do
    before(:each) do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/level-progression/",
                           :body => "spec/fixtures/level-progression.json")
    end

    it "returns a hash with the user's level progression" do
      level_info = Wanikani::Level.progression
      level_info.should be_a(Hash)

      level_info["radicals_progress"].should == 5
      level_info["radicals_total"].should == 9
      level_info["kanji_progress"].should == 10
      level_info["kanji_total"].should == 23
    end
  end

  describe ".radicals" do
    context "levels parameter" do
      it "can accept an Integer as a single level" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/radicals/1",
                             :body => "spec/fixtures/radicals.json")
        Wanikani::Level.radicals(1)
      end

      it "converts an array of Integers to a comma-separated string of levels" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/radicals/2,5,10,25",
                             :body => "spec/fixtures/radicals.json")
        Wanikani::Level.radicals([2, 5, 10, 25])
      end
    end

    context "API response" do
      before(:each) do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/radicals/1",
                             :body => "spec/fixtures/radicals.json")
      end

      it "returns an array of radicals for the specified level" do
        radicals = Wanikani::Level.radicals(1)
        radicals.should be_an(Array)
        radicals.size.should == 2
      end

      it "returns the information relating to the returned radicals" do
        radicals = Wanikani::Level.radicals(1)
        radical = radicals.first
        radical["character"].should == "ト"
        radical["meaning"].should == "toe"
        radical["image"].should be_nil
        radical["level"].should == 1
        radical["stats"].should be_a(Hash)

        stats = radical["stats"]
        stats["srs"].should == "burned"
        stats["unlocked_date"].should == 1337820726
        stats["available_date"].should == 1354754764
        stats["burned"].should be_true
        stats["burned_date"].should == 1354754764
        stats["meaning_correct"].should == 8
        stats["meaning_incorrect"].should == 0
        stats["meaning_max_streak"].should == 8
        stats["meaning_current_streak"].should == 8
        stats["reading_correct"].should be_nil
        stats["reading_incorrect"].should be_nil
        stats["reading_max_streak"].should be_nil
        stats["reading_current_streak"].should be_nil
      end
    end
  end

  describe ".kanji" do
    context "levels parameter" do
      it "can accept an Integer as a single level" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/kanji/1",
                             :body => "spec/fixtures/kanji.json")
        Wanikani::Level.kanji(1)
      end

      it "converts an array of Integers to a comma-separated string of levels" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/kanji/2,5,10,25",
                             :body => "spec/fixtures/kanji.json")
        Wanikani::Level.kanji([2, 5, 10, 25])
      end
    end

    context "API response" do
      before(:each) do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/kanji/1",
                             :body => "spec/fixtures/kanji.json")
      end

      it "returns an array of kanji for the specified level" do
        kanji = Wanikani::Level.kanji(1)
        kanji.should be_an(Array)
        kanji.size.should == 2
      end

      it "returns the information relating to the returned kanji" do
        kanji = Wanikani::Level.kanji(1)
        kanji = kanji.first
        kanji["character"].should == "一"
        kanji["meaning"].should == "one"
        kanji["onyomi"].should == "いち"
        kanji["kunyomi"].should == "ひと.*"
        kanji["important_reading"].should == "onyomi"
        kanji["level"].should == 1
        kanji["stats"].should be_a(Hash)

        stats = kanji["stats"]
        stats["srs"].should == "enlighten"
        stats["unlocked_date"].should == 1338820854
        stats["available_date"].should == 1357346947
        stats["burned"].should be_false
        stats["burned_date"].should == 0
        stats["meaning_correct"].should == 7
        stats["meaning_incorrect"].should == 0
        stats["meaning_max_streak"].should == 7
        stats["meaning_current_streak"].should == 7
        stats["reading_correct"].should == 7
        stats["reading_incorrect"].should == 0
        stats["reading_max_streak"].should == 7
        stats["reading_current_streak"].should == 7
      end
    end
  end

  describe ".vocabulary" do
    context "levels parameter" do
      it "can accept an Integer as a single level" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/vocabulary/1",
                             :body => "spec/fixtures/vocabulary.json")
        Wanikani::Level.vocabulary(1)
      end

      it "converts an array of Integers to a comma-separated string of levels" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/vocabulary/2,5,10,25",
                             :body => "spec/fixtures/vocabulary.json")
        Wanikani::Level.vocabulary([2, 5, 10, 25])
      end
    end

    context "API response" do
      before(:each) do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/vocabulary/1",
                             :body => "spec/fixtures/vocabulary.json")
      end

      it "returns an array of vocabulary for the specified level" do
        vocabulary = Wanikani::Level.vocabulary(1)
        vocabulary.should be_an(Array)
        vocabulary.size.should == 2
      end

      it "returns the information relating to the returned vocabulary" do
        vocabulary = Wanikani::Level.vocabulary(1)
        vocabulary = vocabulary.first
        vocabulary["character"].should == "ふじ山"
        vocabulary["kana"].should == "ふじさん"
        vocabulary["meaning"].should == "mt fuji, mount fuji"
        vocabulary["level"].should == 1
        vocabulary["stats"].should be_a(Hash)

        stats = vocabulary["stats"]
        stats["srs"].should == "enlighten"
        stats["unlocked_date"].should == 1342432965
        stats["available_date"].should == 1358369044
        stats["burned"].should be_false
        stats["burned_date"].should == 0
        stats["meaning_correct"].should == 7
        stats["meaning_incorrect"].should == 0
        stats["meaning_max_streak"].should == 7
        stats["meaning_current_streak"].should == 7
        stats["reading_correct"].should == 7
        stats["reading_incorrect"].should == 0
        stats["reading_max_streak"].should == 7
        stats["reading_current_streak"].should == 7
      end
    end
  end
end
