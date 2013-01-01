# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Wanikani::CriticalItems do
  describe ".critical" do
    context "percentage parameter" do
      it "should raise an ArgumentError if the percentage is out of range (between 0 and 100)" do
        expect {
          Wanikani::CriticalItems.critical(500)
        }.to raise_error(ArgumentError)
      end

      it "defaults the percentage parameter to 75" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/critical-items/75",
                             :body => "spec/fixtures/critical-items.json")
        Wanikani::CriticalItems.critical
      end

      it "uses the specified percentage parameter" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/critical-items/50",
                             :body => "spec/fixtures/critical-items.json")
        Wanikani::CriticalItems.critical(50)
      end
    end

    context "API response" do
      before(:each) do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/critical-items/90",
                             :body => "spec/fixtures/critical-items.json")
      end

      it "returns an array with hash of the user's critical items under the specified percentage" do
        critical = Wanikani::CriticalItems.critical(90)
        critical.should be_an(Array)
        critical.size.should == 3
      end

      it "returns the specific fields and the proper encoding for vocabulary items" do
        critical = Wanikani::CriticalItems.critical(90)
        critical_item = critical.detect { |item| item["type"] == "vocabulary" }
        critical_item["character"].should == "地下"
        critical_item["kana"].should == "ちか"
        critical_item["meaning"].should == "underground"
        critical_item["level"].should == 6
        critical_item["percentage"].should == "84"
      end

      it "returns the specific fields and the proper encoding for Kanji items" do
        critical = Wanikani::CriticalItems.critical(90)
        critical_item = critical.detect { |item| item["type"] == "kanji" }
        critical_item["character"].should == "麦"
        critical_item["meaning"].should == "wheat"
        critical_item["onyomi"].should be_nil
        critical_item["kunyomi"].should == "むぎ"
        critical_item["important_reading"].should == "kunyomi"
        critical_item["level"].should == 5
        critical_item["percentage"].should == "89"
      end

      it "returns the specific fields and the proper encoding for radical items" do
        critical = Wanikani::CriticalItems.critical(90)
        critical_item = critical.detect { |item| item["type"] == "radical" }
        critical_item["character"].should == "亠"
        critical_item["meaning"].should == "lid"
        critical_item["image"].should be_nil
        critical_item["level"].should == 1
        critical_item["percentage"].should == "90"
      end
    end
  end
end
