# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::RecentUnlocks do
  describe ".list" do
    context "limit parameter" do
      it "defaults the limit parameter to 10 items" do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/10").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
        Wanikani::RecentUnlocks.list
      end

      it "uses the specified limit parameter" do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/3").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
        Wanikani::RecentUnlocks.list(3)
      end
    end

    context "API response" do
      before(:each) do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/3").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
      end

      it "returns an array with hashes of the user's recent unlocks" do
        unlocks = Wanikani::RecentUnlocks.list(3)
        expect(unlocks).to be_an(Array)
        expect(unlocks.size).to eq(3)
      end

      it "returns the specific fields and the proper encoding for vocabulary items" do
        unlocks = Wanikani::RecentUnlocks.list(3)
        unlocked_item = unlocks.detect { |unlock| unlock["type"] == "vocabulary" }
        expect(unlocked_item["character"]).to eq("首")
        expect(unlocked_item["kana"]).to eq("くび")
        expect(unlocked_item["meaning"]).to eq("neck")
        expect(unlocked_item["level"]).to eq(6)
        expect(unlocked_item["unlocked_date"]).to eq(1355879555)
      end

      it "returns the specific fields and the proper encoding for Kanji items" do
        unlocks = Wanikani::RecentUnlocks.list(3)
        unlocked_item = unlocks.detect { |unlock| unlock["type"] == "kanji" }
        expect(unlocked_item["character"]).to eq("辺")
        expect(unlocked_item["meaning"]).to eq("area")
        expect(unlocked_item["onyomi"]).to eq("へん")
        expect(unlocked_item["kunyomi"]).to eq("あたり")
        expect(unlocked_item["important_reading"]).to eq("onyomi")
        expect(unlocked_item["level"]).to eq(7)
        expect(unlocked_item["unlocked_date"]).to eq(1355762469)
      end

      it "returns the specific fields and the proper encoding for radical items" do
        unlocks = Wanikani::RecentUnlocks.list(3)
        unlocked_item = unlocks.detect { |unlock| unlock["type"] == "radical" }
        expect(unlocked_item["character"]).to eq("鳥")
        expect(unlocked_item["meaning"]).to eq("bird")
        expect(unlocked_item["image"]).to be_nil
        expect(unlocked_item["level"]).to eq(7)
        expect(unlocked_item["unlocked_date"]).to eq(1355759947)
      end
    end
  end

  describe ".radicals" do
    context "limit parameter" do
      it "defaults the limit parameter for the entire 'recent-unlocks' list to 10 items" do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/10").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
        Wanikani::RecentUnlocks.radicals
      end

      it "uses the specified limit parameter for the entire 'recent-unlocks' list" do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/3").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
        Wanikani::RecentUnlocks.radicals(3)
      end
    end

    context "API response" do
      before(:each) do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/3").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
      end

      it "only returns the radicals from the list of recent unlocks" do
        radicals = Wanikani::RecentUnlocks.radicals(3)
        expect(radicals.size).to eq(1)
      end
    end
  end

  describe ".vocabulary" do
    context "limit parameter" do
      it "defaults the limit parameter for the entire 'recent-unlocks' list to 10 items" do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/10").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
        Wanikani::RecentUnlocks.vocabulary
      end

      it "uses the specified limit parameter for the entire 'recent-unlocks' list" do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/3").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
        Wanikani::RecentUnlocks.vocabulary(3)
      end
    end

    context "API response" do
      before(:each) do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/3").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
      end

      it "only returns the vocabulary from the list of recent unlocks" do
        vocabulary = Wanikani::RecentUnlocks.vocabulary(3)
        expect(vocabulary.size).to eq(1)
      end
    end
  end

  describe ".kanji" do
    context "limit parameter" do
      it "defaults the limit parameter for the entire 'recent-unlocks' list to 10 items" do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/10").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
        Wanikani::RecentUnlocks.kanji
      end

      it "uses the specified limit parameter for the entire 'recent-unlocks' list" do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/3").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
        Wanikani::RecentUnlocks.kanji(3)
      end
    end

    context "API response" do
      before(:each) do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/3").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
      end

      it "only returns the Kanji from the list of recent unlocks" do
        kanji = Wanikani::RecentUnlocks.kanji(3)
        expect(kanji.size).to eq(1)
      end
    end
  end

  describe ".full_response" do
    context "limit parameter" do
      it "defaults the limit parameter to 10 items" do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/10").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
        Wanikani::RecentUnlocks.full_response
      end

      it "uses the specified limit parameter" do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/3").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))
        Wanikani::RecentUnlocks.full_response(3)
      end
    end

    context "API response" do
      it "returns the full response with the user_information and requested_information keys" do
        stub_request(:get, "https://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/recent-unlocks/10").
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"))

        full_response = Wanikani::RecentUnlocks.full_response
        expect(full_response).to have_key("user_information")
        expect(full_response).to have_key("requested_information")
      end
    end
  end
end
