# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::StudyQueue do
  let(:client) { Wanikani::Client.new(api_key: "my-api-key") }

  describe "#study_queue" do
    before(:each) do
      stub_request(:get, wanikani_url(client, "study-queue")).
         to_return(body: File.new("spec/fixtures/study-queue.json"), headers: { "Content-Type" => "application/json" })
    end

    it "returns the user's study queue information" do
      queue = client.study_queue
      expect(queue["lessons_available"]).to eq(77)
      expect(queue["reviews_available"]).to eq(5)
      expect(queue["next_review_date"]).to eq(1355893492)
      expect(queue["reviews_available_next_hour"]).to eq(6)
      expect(queue["reviews_available_next_day"]).to eq(24)
    end
  end

  describe ".lessons_available?" do
    it "returns true if there is at least one lesson available" do
      stub_request(:get, wanikani_url(client, "study-queue")).
         to_return(body: File.new("spec/fixtures/study-queue.json"), headers: { "Content-Type" => "application/json" })

      expect(client.lessons_available?).to eq(true)
    end

    it "returns false if there are no lessons available" do
      stub_request(:get, wanikani_url(client, "study-queue")).
         to_return(body: File.new("spec/fixtures/study-queue-empty.json"), headers: { "Content-Type" => "application/json" })

      expect(client.lessons_available?).to eq(false)
    end
  end

  describe ".reviews_available?" do
    it "returns true if there is at least one review available" do
      stub_request(:get, wanikani_url(client, "study-queue")).
         to_return(body: File.new("spec/fixtures/study-queue.json"), headers: { "Content-Type" => "application/json" })

      expect(client.reviews_available?).to eq(true)
    end

    it "returns false if there are no reviews available" do
      stub_request(:get, wanikani_url(client, "study-queue")).
         to_return(body: File.new("spec/fixtures/study-queue-empty.json"), headers: { "Content-Type" => "application/json" })

      expect(client.reviews_available?).to eq(false)
    end
  end

  describe ".full_response" do
    it "returns the full response with the user_information and requested_information keys" do
      stub_request(:get, wanikani_url(client, "study-queue")).
         to_return(body: File.new("spec/fixtures/study-queue.json"), headers: { "Content-Type" => "application/json" })

      full_response = client.full_study_queue_response
      expect(full_response).to have_key("user_information")
      expect(full_response).to have_key("requested_information")
    end
  end
end
