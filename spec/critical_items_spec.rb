# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::CriticalItems do
  describe ".critical" do
    context "percentage parameter" do
      it "should raise an ArgumentError if the percentage is out of range (between 0 and 100)" do
        expect {
          Wanikani::CriticalItems.critical(500)
        }.to raise_error(ArgumentError)
      end

      it "defaults the percentage parameter to 75" do
        stub_request(:get, "http://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/critical-items/75").
           to_return(body: File.new("spec/fixtures/critical-items.json"))
        Wanikani::CriticalItems.critical
      end

      it "uses the specified percentage parameter" do
        stub_request(:get, "http://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/critical-items/50").
           to_return(body: File.new("spec/fixtures/critical-items.json"))
        Wanikani::CriticalItems.critical(50)
      end
    end

    context "API response" do
      before(:each) do
        stub_request(:get, "http://www.wanikani.com/api/v1.2/user/WANIKANI-API-KEY/critical-items/90").
           to_return(body: File.new("spec/fixtures/critical-items.json"))
      end

      it "returns an array with hash of the user's critical items under the specified percentage" do
        critical = Wanikani::CriticalItems.critical(90)
        expect(critical).to be_an(Array)
        expect(critical.size).to eq(3)
      end

      it "returns the specific fields and the proper encoding for vocabulary items" do
        critical = Wanikani::CriticalItems.critical(90)
        critical_item = critical.detect { |item| item["type"] == "vocabulary" }
        expect(critical_item["character"]).to eq("地下")
        expect(critical_item["kana"]).to eq("ちか")
        expect(critical_item["meaning"]).to eq("underground")
        expect(critical_item["level"]).to eq(6)
        expect(critical_item["percentage"]).to eq("84")
      end

      it "returns the specific fields and the proper encoding for Kanji items" do
        critical = Wanikani::CriticalItems.critical(90)
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
        critical = Wanikani::CriticalItems.critical(90)
        critical_item = critical.detect { |item| item["type"] == "radical" }
        expect(critical_item["character"]).to eq("亠")
        expect(critical_item["meaning"]).to eq("lid")
        expect(critical_item["image"]).to be_nil
        expect(critical_item["level"]).to eq(1)
        expect(critical_item["percentage"]).to eq("90")
      end
    end
  end
end
