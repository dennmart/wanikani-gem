# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::Level do
  describe ".progression" do
    before(:each) do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/level-progression/",
                           :body => "spec/fixtures/level-progression.json")
    end

    it "returns a hash with the user's level progression" do
      level_info = Wanikani::Level.progression
      expect(level_info).to be_a(Hash)

      expect(level_info["current_level"]).to eq(25)
      expect(level_info["radicals_progress"]).to eq(5)
      expect(level_info["radicals_total"]).to eq(9)
      expect(level_info["kanji_progress"]).to eq(10)
      expect(level_info["kanji_total"]).to eq(23)
    end
  end

  describe ".radicals" do
    context "levels parameter" do
      it "can accept an Integer as a single level" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/radicals/1",
                             :body => "spec/fixtures/radicals.json")
        Wanikani::Level.radicals(1)
      end

      it "converts an array of Integers to a comma-separated string of levels" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/radicals/2,5,10,25",
                             :body => "spec/fixtures/radicals.json")
        Wanikani::Level.radicals([2, 5, 10, 25])
      end
    end

    context "API response" do
      before(:each) do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/radicals/1",
                             :body => "spec/fixtures/radicals.json")
      end

      it "returns an array of radicals for the specified level" do
        radicals = Wanikani::Level.radicals(1)
        expect(radicals).to be_an(Array)
        expect(radicals.size).to eq(2)
      end

      it "returns the information relating to the returned radicals" do
        radicals = Wanikani::Level.radicals(1)
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

  describe ".kanji" do
    context "levels parameter" do
      it "can accept an Integer as a single level" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/kanji/1",
                             :body => "spec/fixtures/kanji.json")
        Wanikani::Level.kanji(1)
      end

      it "converts an array of Integers to a comma-separated string of levels" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/kanji/2,5,10,25",
                             :body => "spec/fixtures/kanji.json")
        Wanikani::Level.kanji([2, 5, 10, 25])
      end
    end

    context "API response" do
      before(:each) do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/kanji/1",
                             :body => "spec/fixtures/kanji.json")
      end

      it "returns an array of kanji for the specified level" do
        kanji = Wanikani::Level.kanji(1)
        expect(kanji).to be_an(Array)
        expect(kanji.size).to eq(2)
      end

      it "returns the information relating to the returned kanji" do
        kanji = Wanikani::Level.kanji(1)
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

  describe ".vocabulary" do
    context "levels parameter" do
      it "can accept an Integer as a single level" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/vocabulary/1",
                             :body => "spec/fixtures/vocabulary.json")
        Wanikani::Level.vocabulary(1)
      end

      it "converts an array of Integers to a comma-separated string of levels" do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/vocabulary/2,5,10,25",
                             :body => "spec/fixtures/vocabulary.json")
        Wanikani::Level.vocabulary([2, 5, 10, 25])
      end
    end

    context "API response" do
      before(:each) do
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/vocabulary/1",
                             :body => "spec/fixtures/vocabulary.json")
      end

      it "returns an array of vocabulary for the specified level" do
        vocabulary = Wanikani::Level.vocabulary(1)
        expect(vocabulary).to be_an(Array)
        expect(vocabulary.size).to eq(2)
      end

      it "returns the information relating to the returned vocabulary" do
        vocabulary = Wanikani::Level.vocabulary(1)
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
        FakeWeb.register_uri(:get,
                             "http://www.wanikani.com/api/user/WANIKANI-API-KEY/vocabulary/",
                             :body => "spec/fixtures/vocabulary_all_levels.json")

        vocabulary = Wanikani::Level.vocabulary
        expect(vocabulary).to be_an(Array)
      end
    end
  end
end
