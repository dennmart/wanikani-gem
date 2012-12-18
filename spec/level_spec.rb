require 'spec_helper'

describe Wanikani::Level do
  describe ".progression" do
    before(:each) do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/level-progression/",
                           :body => "spec/fixtures/level-progression.json")
    end

    it "returns a hash with the user's level progression" do
      level_info = Wanikani::Level.progression
      level_info.should be_a(Hash)

      level_info["radicals_progress"].should == 5
      level_info["radicals_total"].should == 9
      level_info["kanji_progress"].should == 10
      level_info["kanji_total"].should == 23
    end
  end
end

