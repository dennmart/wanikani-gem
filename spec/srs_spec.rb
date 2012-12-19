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
end