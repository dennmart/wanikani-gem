# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::CriticalItems do
  let(:client) { Wanikani::Client.new(api_key: "my-api-key") }

  describe "#critical_items" do
    context "percentage parameter" do
      it "should raise an ArgumentError if the percentage is out of range (between 0 and 100)" do
        expect {
          client.critical_items(500)
        }.to raise_error(ArgumentError)
      end

      it "defaults the percentage parameter to 75" do
        stub_request(:get, wanikani_url(client, "critical-items", 75)).
           to_return(body: File.new("spec/fixtures/critical-items.json"), headers: { "Content-Type" => "application/json" })
        client.critical_items
      end

      it "uses the specified percentage parameter" do
        stub_request(:get, wanikani_url(client, "critical-items", 50)).
           to_return(body: File.new("spec/fixtures/critical-items.json"), headers: { "Content-Type" => "application/json" })
        client.critical_items(50)
      end
    end

    context "API response" do
      before(:each) do
        stub_request(:get, wanikani_url(client, "critical-items", 90)).
           to_return(body: File.new("spec/fixtures/critical-items.json"), headers: { "Content-Type" => "application/json" })
      end

      it "returns an array with hash of the user's critical items under the specified percentage" do
        critical = client.critical_items(90)
        expect(critical).to be_an(Array)
        expect(critical.size).to eq(3)
      end

      it "returns the specific fields and the proper encoding for vocabulary items" do
        critical = client.critical_items(90)
        critical_item = critical.detect { |item| item["type"] == "vocabulary" }
        expect(critical_item["character"]).to eq("地下")
        expect(critical_item["kana"]).to eq("ちか")
        expect(critical_item["meaning"]).to eq("underground")
        expect(critical_item["level"]).to eq(6)
        expect(critical_item["percentage"]).to eq("84")
      end

      it "returns the specific fields and the proper encoding for Kanji items" do
        critical = client.critical_items(90)
        critical_item = critical.detect { |item| item["type"] == "kanji" }
        expect(critical_item["character"]).to eq("麦")
        expect(critical_item["meaning"]).to eq("wheat")
        expect(critical_item["onyomi"]).to be_nil
        expect(critical_item["kunyomi"]).to eq("むぎ")
        expect(critical_item["important_reading"]).to eq("kunyomi")
        expect(critical_item["level"]).to eq(5)
        expect(critical_item["percentage"]).to eq("89")
      end

      it "returns the specific fields and the proper encoding for radical items" do
        critical = client.critical_items(90)
        critical_item = critical.detect { |item| item["type"] == "radical" }
        expect(critical_item["character"]).to eq("亠")
        expect(critical_item["meaning"]).to eq("lid")
        expect(critical_item["image"]).to be_nil
        expect(critical_item["level"]).to eq(1)
        expect(critical_item["percentage"]).to eq("90")
      end
    end
  end

  describe ".full_critical_items_response" do
    context "percentage parameter" do
      it "defaults the percentage parameter to 75" do
        stub_request(:get, wanikani_url(client, "critical-items", 75)).
           to_return(body: File.new("spec/fixtures/critical-items.json"), headers: { "Content-Type" => "application/json" })
        client.full_critical_items_response
      end

      it "uses the specified percentage parameter" do
        stub_request(:get, wanikani_url(client, "critical-items", 50)).
           to_return(body: File.new("spec/fixtures/critical-items.json"), headers: { "Content-Type" => "application/json" })
        client.full_critical_items_response(50)
      end
    end

    context "API response" do
      it "returns the full response with the user_information and requested_information keys" do
        stub_request(:get, wanikani_url(client, "critical-items", 75)).
           to_return(body: File.new("spec/fixtures/critical-items.json"), headers: { "Content-Type" => "application/json" })

        full_response = client.full_critical_items_response
        expect(full_response).to have_key("user_information")
        expect(full_response).to have_key("requested_information")
      end
    end
  end
end
