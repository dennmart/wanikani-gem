# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::RecentUnlocks do
  let(:client) { Wanikani::Client.new(api_key: "my-api-key") }

  describe "#recent_unlocks" do
    context "limit parameter" do
      it "sets the limit parameter if specified" do
        stub_request(:get, wanikani_url(client, "recent-unlocks", 3)).
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"), headers: { "Content-Type" => "application/json" })
        client.recent_unlocks({ limit: 3 })
      end
    end

    context "API response" do
      before(:each) do
        stub_request(:get, wanikani_url(client, "recent-unlocks", 3)).
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"), headers: { "Content-Type" => "application/json" })
      end

      it "returns an array with hashes of the user's recent unlocks" do
        unlocks = client.recent_unlocks({ limit: 3 })
        expect(unlocks).to be_an(Array)
        expect(unlocks.size).to eq(3)
      end

      it "returns the specific fields and the proper encoding for vocabulary items" do
        unlocks = client.recent_unlocks({ limit: 3 })
        unlocked_item = unlocks.detect { |unlock| unlock["type"] == "vocabulary" }
        expect(unlocked_item["character"]).to eq("首")
        expect(unlocked_item["kana"]).to eq("くび")
        expect(unlocked_item["meaning"]).to eq("neck")
        expect(unlocked_item["level"]).to eq(6)
        expect(unlocked_item["unlocked_date"]).to eq(1355879555)
      end

      it "returns the specific fields and the proper encoding for Kanji items" do
        unlocks = client.recent_unlocks({ limit: 3 })
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
        unlocks = client.recent_unlocks({ limit: 3 })
        unlocked_item = unlocks.detect { |unlock| unlock["type"] == "radical" }
        expect(unlocked_item["character"]).to eq("鳥")
        expect(unlocked_item["meaning"]).to eq("bird")
        expect(unlocked_item["image"]).to be_nil
        expect(unlocked_item["level"]).to eq(7)
        expect(unlocked_item["unlocked_date"]).to eq(1355759947)
      end

      it "only returns specified item type from the list of recent unlocks if the type is specified" do
        radicals = client.recent_unlocks({ limit: 3, type: "radical" })
        expect(radicals.size).to eq(1)
        expect(radicals.first["type"]).to eq("radical")

        kanji = client.recent_unlocks({ limit: 3, type: "kanji" })
        expect(kanji.size).to eq(1)
        expect(kanji.first["type"]).to eq("kanji")

        vocabulary = client.recent_unlocks({ limit: 3, type: "vocabulary" })
        expect(vocabulary.size).to eq(1)
        expect(vocabulary.first["type"]).to eq("vocabulary")
      end
    end
  end

  describe "#full_recent_unlocks_response" do
    context "limit parameter" do
      it "uses the specified limit parameter" do
        stub_request(:get, wanikani_url(client, "recent-unlocks", 3)).
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"), headers: { "Content-Type" => "application/json" })
        client.full_recent_unlocks_response({ limit: 3 })
      end
    end

    context "API response" do
      it "returns the full response with the user_information and requested_information keys" do
        stub_request(:get, wanikani_url(client, "recent-unlocks")).
           to_return(body: File.new("spec/fixtures/recent-unlocks.json"), headers: { "Content-Type" => "application/json" })

        full_response = client.full_recent_unlocks_response
        expect(full_response).to have_key("user_information")
        expect(full_response).to have_key("requested_information")
      end
    end
  end
end
