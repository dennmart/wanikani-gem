# encoding: utf-8
require 'spec_helper'

describe Wanikani::RecentUnlocks do
  describe ".list" do
    context "limit parameter" do
      it "defaults the limit parameter to 10 items" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/recent-unlocks/10",
                             :body => "spec/fixtures/recent-unlocks.json")
        Wanikani::RecentUnlocks.list
      end

      it "uses the specified limit parameter" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/recent-unlocks/3",
                             :body => "spec/fixtures/recent-unlocks.json")
        Wanikani::RecentUnlocks.list(3)
      end
    end

    context "API response" do
      before(:each) do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/recent-unlocks/3",
                             :body => "spec/fixtures/recent-unlocks.json")
      end

      it "returns an array with hashes of the user's recent unlocks" do
        unlocks = Wanikani::RecentUnlocks.list(3)
        unlocks.should be_an(Array)
        unlocks.size.should == 3
      end

      it "returns the specific fields and the proper encoding for vocabulary items" do
        unlocks = Wanikani::RecentUnlocks.list(3)
        unlocked_item = unlocks.detect { |unlock| unlock["type"] == "vocabulary" }
        unlocked_item["character"].should == "首"
        unlocked_item["kana"].should == "くび"
        unlocked_item["meaning"].should == "neck"
        unlocked_item["level"].should == 6
        unlocked_item["unlocked_date"].should == 1355879555
      end

      it "returns the specific fields and the proper encoding for Kanji items" do
        unlocks = Wanikani::RecentUnlocks.list(3)
        unlocked_item = unlocks.detect { |unlock| unlock["type"] == "kanji" }
        unlocked_item["character"].should == "辺"
        unlocked_item["meaning"].should == "area"
        unlocked_item["onyomi"].should == "へん"
        unlocked_item["kunyomi"].should == "あたり"
        unlocked_item["important_reading"].should == "onyomi"
        unlocked_item["level"].should == 7
        unlocked_item["unlocked_date"].should == 1355762469
      end

      it "returns the specific fields and the proper encoding for radical items" do
        unlocks = Wanikani::RecentUnlocks.list(3)
        unlocked_item = unlocks.detect { |unlock| unlock["type"] == "radical" }
        unlocked_item["character"].should == "鳥"
        unlocked_item["meaning"].should == "bird"
        unlocked_item["image"].should be_nil
        unlocked_item["level"].should == 7
        unlocked_item["unlocked_date"].should == 1355759947
      end
    end
  end
end
