require 'spec_helper'

describe Wanikani do
  describe "API key accessors" do
    it "sets and gets the API key" do
      Wanikani.api_key = "testing-wanikani-api-key"
      Wanikani.api_key.should == "testing-wanikani-api-key"
    end
  end

  describe ".api_response" do
    it "raises an ArgumentError if the resource parameter is nil" do
      expect {
        Wanikani.api_response(nil)
      }.to raise_error(ArgumentError)
    end

    it "raises an ArgumentError if the resource parameter is an empty string" do
      expect {
        Wanikani.api_response("")
      }.to raise_error(ArgumentError)
    end

    it "raises an ArgumentError if the API key is nil" do
      Wanikani.api_key = nil
      expect {
        Wanikani.api_response("user-information")
      }.to raise_error(ArgumentError)
    end

    it "raises an ArgumentError if the API key is an empty string" do
      Wanikani.api_key = ""
      expect {
        Wanikani.api_response("user-information")
      }.to raise_error(ArgumentError)
    end

    it "calls the Wanikani API endpoint with the resource parameter" do
      RestClient.should_receive(:get).with("#{Wanikani::API_ENDPOINT}/#{Wanikani.api_key}/resource/").and_return("{}")
      Wanikani.api_response("resource")
    end

    it "raises an exception if the API response contains the 'error' key" do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/user-information/",
                           :body => "spec/fixtures/error.json")

      expect {
        Wanikani.api_response("user-information")
      }.to raise_error(Exception, "There was an error fetching the data from Wanikani (User does not exist.)")
    end

    it "returns the JSON parsed as a Hash" do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/user-information/",
                           :body => "spec/fixtures/user-information.json")

      MultiJson.should_receive(:load).with(File.read("spec/fixtures/user-information.json")).and_call_original
      api_response = Wanikani.api_response("user-information")
      api_response.should be_a(Hash)
    end
  end
end
