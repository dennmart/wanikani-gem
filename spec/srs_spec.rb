# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::SRS do
  describe ".distribution" do
    let(:srs_types) { Wanikani::SRS::ITEM_TYPES.reject!{ |type| type == "all" } }

    before(:each) do
      stub_request(:get, "http://www.wanikani.com/api/user/WANIKANI-API-KEY/srs-distribution/").
         to_return(body: File.new("spec/fixtures/srs-distribution.json"))
    end

    it "raises an ArgumentError if the item_type parameter is not a valid item type" do
      expect {
        Wanikani::SRS.distribution("blah")
      }.to raise_error(ArgumentError)
    end

    it "returns a hash with all SRS information if no parameters are passed" do
      srs = Wanikani::SRS.distribution
      expect(srs).to be_a(Hash)

      srs_types.each do |type|
        expect(srs.keys).to include(type)
      end
    end

    it "only returns the information of a specified type if sent as a parameter" do
      srs = Wanikani::SRS.distribution("apprentice")
      expect(srs["radicals"]).to eq(1)
      expect(srs["kanji"]).to eq(4)
      expect(srs["vocabulary"]).to eq(12)
      expect(srs["total"]).to eq(17)
    end
  end

  describe ".items_by_type" do
    before(:each) do
      stub_request(:get, "http://www.wanikani.com/api/user/WANIKANI-API-KEY/radicals/").
         to_return(body: File.new("spec/fixtures/srs-radicals.json"))

      stub_request(:get, "http://www.wanikani.com/api/user/WANIKANI-API-KEY/kanji/").
         to_return(body: File.new("spec/fixtures/srs-kanji.json"))

      stub_request(:get, "http://www.wanikani.com/api/user/WANIKANI-API-KEY/vocabulary/").
         to_return(body: File.new("spec/fixtures/srs-vocabulary.json"))
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
      expect(Wanikani::SRS.items_by_type("burned").size).to eq(3)
      expect(Wanikani::SRS.items_by_type("enlighten").size).to eq(1)
      expect(Wanikani::SRS.items_by_type("master").size).to eq(0)
      expect(Wanikani::SRS.items_by_type("guru").size).to eq(1)
      expect(Wanikani::SRS.items_by_type("apprentice").size).to eq(1)
    end

    it "includes the type of the item (radical, kanji or vocabulary) in the returned items" do
      apprentice_item = Wanikani::SRS.items_by_type("apprentice").first
      expect(apprentice_item["type"]).to eq("kanji")
    end

    it "uses 'radical' instead of 'radicals' as the type of the item" do
      enlightened_item = Wanikani::SRS.items_by_type("enlighten").first
      expect(enlightened_item["type"]).to eq("radical")
    end
  end
end
