# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Wanikani::StudyQueue do
  describe ".queue" do
    before(:each) do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/study-queue/",
                           :body => "spec/fixtures/study-queue.json")
    end

    it "returns the user's study queue information" do
      queue = Wanikani::StudyQueue.queue
      queue["lessons_available"].should == 77
      queue["reviews_available"].should == 5
      queue["next_review_date"].should == 1355893492
      queue["reviews_available_next_hour"].should == 6
      queue["reviews_available_next_day"].should == 24
    end
  end

  describe ".lessons_available?" do
    it "returns true if there is at least one lesson available" do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/study-queue/",
                           :body => "spec/fixtures/study-queue.json")

      Wanikani::StudyQueue.lessons_available?.should be_true
    end

    it "returns false if there are no lessons available" do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/study-queue/",
                           :body => "spec/fixtures/study-queue-empty.json")

      Wanikani::StudyQueue.lessons_available?.should be_false
    end
  end

  describe ".reviews_available?" do
    it "returns true if there is at least one review available" do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/study-queue/",
                           :body => "spec/fixtures/study-queue.json")

      Wanikani::StudyQueue.reviews_available?.should be_true
    end

    it "returns false if there are no reviews available" do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/study-queue/",
                           :body => "spec/fixtures/study-queue-empty.json")

      Wanikani::StudyQueue.reviews_available?.should be_false
    end
  end
end
