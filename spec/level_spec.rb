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

      it "converts an array of Integers to a comma-separate string of levels" do
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
end

