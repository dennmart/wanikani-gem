# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::Level do
  let(:client) { Wanikani::Client.new(api_key: "my-api-key") }

  describe "#level_progression" do
    before(:each) do
      stub_request(:get, wanikani_url(client, "level-progression")).
         to_return(body: File.new("spec/fixtures/level-progression.json"), headers: { "Content-Type" => "application/json" })
    end

    it "returns a hash with the user's level progression" do
      level_info = client.level_progression
      expect(level_info).to be_a(Hash)

      expect(level_info["current_level"]).to eq(25)
      expect(level_info["radicals_progress"]).to eq(5)
      expect(level_info["radicals_total"]).to eq(9)
      expect(level_info["kanji_progress"]).to eq(10)
      expect(level_info["kanji_total"]).to eq(23)
    end
  end

  describe "#radicals_list" do
    context "levels parameter" do
      it "can accept an Integer as a single level" do
        stub_request(:get, wanikani_url(client, "radicals", 1)).
           to_return(body: File.new("spec/fixtures/radicals.json"), headers: { "Content-Type" => "application/json" })

        client.radicals_list(1)
      end

      it "converts an array of Integers to a comma-separated string of levels" do
        stub_request(:get, wanikani_url(client, "radicals", "2,5,10,25")).
           to_return(body: File.new("spec/fixtures/radicals.json"), headers: { "Content-Type" => "application/json" })

        client.radicals_list([2, 5, 10, 25])
      end
    end

    context "API response" do
      before(:each) do
        stub_request(:get, wanikani_url(client, "radicals", 1)).
           to_return(body: File.new("spec/fixtures/radicals.json"), headers: { "Content-Type" => "application/json" })
      end

      it "returns an array of radicals for the specified level" do
        radicals = client.radicals_list(1)
        expect(radicals).to be_an(Array)
        expect(radicals.size).to eq(2)
      end

      it "returns the information relating to the returned radicals" do
        radicals = client.radicals_list(1)
        radical = radicals.first
        expect(radical["character"]).to eq("ト")
        expect(radical["meaning"]).to eq("toe")
        expect(radical["image"]).to be_nil
        expect(radical["level"]).to eq(1)
        expect(radical["stats"]).to be_a(Hash)

        stats = radical["stats"]
        expect(stats["srs"]).to eq("burned")
        expect(stats["unlocked_date"]).to eq(1337820726)
        expect(stats["available_date"]).to eq(1354754764)
        expect(stats["burned"]).to be_truthy
        expect(stats["burned_date"]).to eq(1354754764)
        expect(stats["meaning_correct"]).to eq(8)
        expect(stats["meaning_incorrect"]).to eq(0)
        expect(stats["meaning_max_streak"]).to eq(8)
        expect(stats["meaning_current_streak"]).to eq(8)
        expect(stats["reading_correct"]).to be_nil
        expect(stats["reading_incorrect"]).to be_nil
        expect(stats["reading_max_streak"]).to be_nil
        expect(stats["reading_current_streak"]).to be_nil
      end
    end
  end

  describe "#kanji_list" do
    context "levels parameter" do
      it "can accept an Integer as a single level" do
        stub_request(:get, wanikani_url(client, "kanji", 1)).
           to_return(body: File.new("spec/fixtures/kanji.json"), headers: { "Content-Type" => "application/json" })

        client.kanji_list(1)
      end

      it "converts an array of Integers to a comma-separated string of levels" do
        stub_request(:get, wanikani_url(client, "kanji", "2,5,10,25")).
           to_return(body: File.new("spec/fixtures/kanji.json"), headers: { "Content-Type" => "application/json" })

        client.kanji_list([2, 5, 10, 25])
      end
    end

    context "API response" do
      before(:each) do
        stub_request(:get, wanikani_url(client, "kanji", 1)).
           to_return(body: File.new("spec/fixtures/kanji.json"), headers: { "Content-Type" => "application/json" })
      end

      it "returns an array of kanji for the specified level" do
        kanji = client.kanji_list(1)
        expect(kanji).to be_an(Array)
        expect(kanji.size).to eq(2)
      end

      it "returns the information relating to the returned kanji" do
        kanji = client.kanji_list(1)
        kanji = kanji.first
        expect(kanji["character"]).to eq("一")
        expect(kanji["meaning"]).to eq("one")
        expect(kanji["onyomi"]).to eq("いち")
        expect(kanji["kunyomi"]).to eq("ひと.*")
        expect(kanji["important_reading"]).to eq("onyomi")
        expect(kanji["level"]).to eq(1)
        expect(kanji["stats"]).to be_a(Hash)

        stats = kanji["stats"]
        expect(stats["srs"]).to eq("enlighten")
        expect(stats["unlocked_date"]).to eq(1338820854)
        expect(stats["available_date"]).to eq(1357346947)
        expect(stats["burned"]).to be_falsey
        expect(stats["burned_date"]).to eq(0)
        expect(stats["meaning_correct"]).to eq(7)
        expect(stats["meaning_incorrect"]).to eq(0)
        expect(stats["meaning_max_streak"]).to eq(7)
        expect(stats["meaning_current_streak"]).to eq(7)
        expect(stats["reading_correct"]).to eq(7)
        expect(stats["reading_incorrect"]).to eq(0)
        expect(stats["reading_max_streak"]).to eq(7)
        expect(stats["reading_current_streak"]).to eq(7)
      end
    end
  end

  describe "#vocabulary_list" do
    context "levels parameter" do
      it "can accept an Integer as a single level" do
        stub_request(:get, wanikani_url(client, "vocabulary", 1)).
           to_return(body: File.new("spec/fixtures/vocabulary.json"), headers: { "Content-Type" => "application/json" })

        client.vocabulary_list(1)
      end

      it "converts an array of Integers to a comma-separated string of levels" do
        stub_request(:get, wanikani_url(client, "vocabulary", "2,5,10,25")).
           to_return(body: File.new("spec/fixtures/vocabulary.json"), headers: { "Content-Type" => "application/json" })

        client.vocabulary_list([2, 5, 10, 25])
      end
    end

    context "API response" do
      before(:each) do
        stub_request(:get, wanikani_url(client, "vocabulary", 1)).
           to_return(body: File.new("spec/fixtures/vocabulary.json"), headers: { "Content-Type" => "application/json" })
      end

      it "returns an array of vocabulary for the specified level" do
        vocabulary = client.vocabulary_list(1)
        expect(vocabulary).to be_an(Array)
        expect(vocabulary.size).to eq(2)
      end

      it "returns the information relating to the returned vocabulary" do
        vocabulary = client.vocabulary_list(1)
        vocabulary = vocabulary.first
        expect(vocabulary["character"]).to eq("ふじ山")
        expect(vocabulary["kana"]).to eq("ふじさん")
        expect(vocabulary["meaning"]).to eq("mt fuji, mount fuji")
        expect(vocabulary["level"]).to eq(1)
        expect(vocabulary["stats"]).to be_a(Hash)

        stats = vocabulary["stats"]
        expect(stats["srs"]).to eq("enlighten")
        expect(stats["unlocked_date"]).to eq(1342432965)
        expect(stats["available_date"]).to eq(1358369044)
        expect(stats["burned"]).to be_falsey
        expect(stats["burned_date"]).to eq(0)
        expect(stats["meaning_correct"]).to eq(7)
        expect(stats["meaning_incorrect"]).to eq(0)
        expect(stats["meaning_max_streak"]).to eq(7)
        expect(stats["meaning_current_streak"]).to eq(7)
        expect(stats["reading_correct"]).to eq(7)
        expect(stats["reading_incorrect"]).to eq(0)
        expect(stats["reading_max_streak"]).to eq(7)
        expect(stats["reading_current_streak"]).to eq(7)
      end

      it "returns an array when fetching vocabulary without specifying a level" do
        stub_request(:get, wanikani_url(client, "vocabulary")).
           to_return(body: File.new("spec/fixtures/vocabulary_all_levels.json"), headers: { "Content-Type" => "application/json" })

        vocabulary = client.vocabulary_list
        expect(vocabulary).to be_an(Array)
      end
    end
  end

  describe "#full_level_progression_response" do
    it "returns the full response with the user_information and requested_information keys" do
      stub_request(:get, wanikani_url(client, "level-progression")).
         to_return(body: File.new("spec/fixtures/level-progression.json"), headers: { "Content-Type" => "application/json" })

      full_response = client.full_level_progression_response
      expect(full_response).to have_key("user_information")
      expect(full_response).to have_key("requested_information")
    end
  end
end
