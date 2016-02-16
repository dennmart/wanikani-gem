# -*- encoding : utf-8 -*-
RSpec.describe Wanikani do
  describe "API key accessors" do
    it "sets and gets the API key" do
      Wanikani.api_key = "testing-wanikani-api-key"
      expect(Wanikani.api_key).to eq("testing-wanikani-api-key")
    end
  end

  describe "API version accessors" do
    it "sets the default API version if it's not set" do
      Wanikani.api_version = nil
      expect(Wanikani.api_version).to eq(Wanikani::DEFAULT_API_VERSION)
    end

    it "raises an ArgumentError if attempting to set an invalid API version" do
      expect {
        Wanikani.api_version = "invalid_api_version"
      }.to raise_error(ArgumentError)
    end

    it "sets and gets the API version" do
      Wanikani.api_version = "v1"
      expect(Wanikani.api_version).to eq("v1")
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
      stubs = Faraday::Adapter::Test::Stubs.new
      faraday = Faraday.new do |builder|
        builder.adapter :test, stubs do |stub|
          stub.get("/api/#{Wanikani.api_version}/user/#{Wanikani.api_key}/resource/") { [200, {}, {}] }
        end
      end

      allow(Faraday).to receive(:new).and_return(faraday)
      Wanikani.api_response("resource")
      stubs.verify_stubbed_calls
    end

    it "raises an exception if the API response contains the 'error' key" do
      stub_request(:get, "https://www.wanikani.com/api/#{Wanikani.api_version}/user/WANIKANI-API-KEY/user-information/").
         to_return(body: File.new("spec/fixtures/error.json"), headers: { "Content-Type" => "application/json"  })

      expect {
        Wanikani.api_response("user-information")
      }.to raise_error(Wanikani::Exception, "There was an error fetching the data from Wanikani (User does not exist.)")
    end

    it "returns the JSON parsed as a Hash" do
      stub_request(:get, "https://www.wanikani.com/api/#{Wanikani.api_version}/user/WANIKANI-API-KEY/user-information/").
         to_return(body: File.new("spec/fixtures/user-information.json"), headers: { "Content-Type" => "application/json"  })

      api_response = Wanikani.api_response("user-information")
      expect(api_response).to be_a(Hash)
    end
  end

  describe ".valid_api_key?" do
    context "specifying parameter" do
      before(:each) do
        Wanikani.api_key = nil
      end

      it "returns false if the parameter is nil" do
        expect(Wanikani.valid_api_key?(nil)).to be_falsey
      end

      it "returns false if the parameter is an emptry string" do
        expect(Wanikani.valid_api_key?("")).to be_falsey
      end

      it "returns false if the API call to WaniKani contains an error" do
        stub_request(:get, "https://www.wanikani.com/api/#{Wanikani.api_version}/user/invalid-api-key/user-information").
           to_return(body: File.new("spec/fixtures/error.json"), headers: { "Content-Type" => "application/json"  })
        expect(Wanikani.valid_api_key?("invalid-api-key")).to be_falsey
      end

      it "returns false if the API call to WaniKani is valid" do
        stub_request(:get, "https://www.wanikani.com/api/#{Wanikani.api_version}/user/valid-api-key/user-information").
           to_return(body: File.new("spec/fixtures/user-information.json"), headers: { "Content-Type" => "application/json" })
        expect(Wanikani.valid_api_key?("valid-api-key")).to be_truthy
      end
    end

    context "without specifying parameter" do
      it "returns false if Wanikani.api_key is nil" do
        Wanikani.api_key = nil
        expect(Wanikani.valid_api_key?).to be_falsey
      end

      it "returns false if Wanikani.api_key is an empty string" do
        Wanikani.api_key = ""
        expect(Wanikani.valid_api_key?).to be_falsey
      end

      it "returns false if the API call to WaniKani contains an error" do
        stub_request(:get, "https://www.wanikani.com/api/#{Wanikani.api_version}/user/WANIKANI-API-KEY/user-information").
           to_return(body: File.new("spec/fixtures/error.json"), headers: { "Content-Type" => "application/json"  })
        expect(Wanikani.valid_api_key?).to be_falsey
      end

      it "returns false if the API call to WaniKani is valid" do
        stub_request(:get, "https://www.wanikani.com/api/#{Wanikani.api_version}/user/WANIKANI-API-KEY/user-information").
           to_return(body: File.new("spec/fixtures/user-information.json"), headers: { "Content-Type" => "application/json"  })
        expect(Wanikani.valid_api_key?).to be_truthy
      end
    end
  end
end
