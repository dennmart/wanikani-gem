# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Wanikani::SRS do
  describe ".distribution" do
    let(:srs_types) { Wanikani::SRS::ITEM_TYPES.reject!{ |type| type == "all" } }

    before(:each) do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/srs-distribution/",
                           :body => "spec/fixtures/srs-distribution.json")
    end

    it "raises an ArgumentError if the item_type parameter is not a valid item type" do
      expect {
        Wanikani::SRS.distribution("blah")
      }.to raise_error(ArgumentError)
    end

    it "returns a hash with all SRS information if no parameters are passed" do
      srs = Wanikani::SRS.distribution
      srs.should be_a(Hash)

      srs_types.each do |type|
        srs.keys.should include(type)
      end
    end

    it "only returns the information of a specified type if sent as a parameter" do
      srs = Wanikani::SRS.distribution("apprentice")
      srs["radicals"].should == 1
      srs["kanji"].should == 4
      srs["vocabulary"].should == 12
      srs["total"].should == 17
    end
  end

  describe ".items_by_type" do
    before(:each) do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/radicals/",
                           :body => "spec/fixtures/srs-radicals.json")

      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/kanji/",
                           :body => "spec/fixtures/srs-kanji.json")

      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/vocabulary/",
                           :body => "spec/fixtures/srs-vocabulary.json")
    end
    it "raises an ArgumentError if the item_type parameter is not a valid item type" do
      expect {
        Wanikani::SRS.items_by_type("blah")
      }.to raise_error(ArgumentError)
    end

    it "raises an ArgumentError if the item_type parameter is 'all'" do
      expect {
        Wanikani::SRS.items_by_type("all")
      }.to raise_error(ArgumentError)
    end

    it "returns all items matching the specific argument" do
      Wanikani::SRS.items_by_type("burned").size.should == 3
      Wanikani::SRS.items_by_type("enlighten").size.should == 1
      Wanikani::SRS.items_by_type("master").size.should == 0
      Wanikani::SRS.items_by_type("guru").size.should == 1
      Wanikani::SRS.items_by_type("apprentice").size.should == 1
    end

    it "includes the type of the item (radical, kanji or vocabulary) in the returned items" do
      apprentice_item = Wanikani::SRS.items_by_type("apprentice").first
      apprentice_item["type"].should == "kanji"
    end

    it "uses 'radical' instead of 'radicals' as the type of the item" do
      enlightened_item = Wanikani::SRS.items_by_type("enlighten").first
      enlightened_item["type"].should == "radical"
    end
  end
end
