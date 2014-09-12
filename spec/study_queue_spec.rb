# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::StudyQueue do
  describe ".queue" do
    before(:each) do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/study-queue/",
                           :body => "spec/fixtures/study-queue.json")
    end

    it "returns the user's study queue information" do
      queue = Wanikani::StudyQueue.queue
      expect(queue["lessons_available"]).to eq(77)
      expect(queue["reviews_available"]).to eq(5)
      expect(queue["next_review_date"]).to eq(1355893492)
      expect(queue["reviews_available_next_hour"]).to eq(6)
      expect(queue["reviews_available_next_day"]).to eq(24)
    end
  end

  describe ".lessons_available?" do
    it "returns true if there is at least one lesson available" do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/study-queue/",
                           :body => "spec/fixtures/study-queue.json")

      expect(Wanikani::StudyQueue.lessons_available?).to be_truthy
    end

    it "returns false if there are no lessons available" do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/study-queue/",
                           :body => "spec/fixtures/study-queue-empty.json")

      expect(Wanikani::StudyQueue.lessons_available?).to be_falsey
    end
  end

  describe ".reviews_available?" do
    it "returns true if there is at least one review available" do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/study-queue/",
                           :body => "spec/fixtures/study-queue.json")

      expect(Wanikani::StudyQueue.reviews_available?).to be_truthy
    end

    it "returns false if there are no reviews available" do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/study-queue/",
                           :body => "spec/fixtures/study-queue-empty.json")

      expect(Wanikani::StudyQueue.reviews_available?).to be_falsey
    end
  end
end
