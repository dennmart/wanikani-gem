# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::Client do
  describe "#initialize" do
    it "raises an ArgumentError if the API key is not set" do
      expect {
        Wanikani::Client.new
      }.to raise_error(ArgumentError, "You must specify a WaniKani API key before querying the API.")
    end

    it "raises an ArgumentError if attempting to set an invalid API version" do
      expect {
        Wanikani::Client.new(api_key: "my-api-key", api_version: "bad-api-version")
      }.to raise_error(ArgumentError, "API version should be one of the following: #{Wanikani::VALID_API_VERSIONS.join(', ')}.")
    end

    it "uses the default API version if it's not set on initialization" do
      client = Wanikani::Client.new(api_key: "my-api-key")
      expect(client.api_version).to eq(Wanikani::DEFAULT_API_VERSION)
    end
  end

  describe "#valid_api_key?" do
    let(:client) { Wanikani::Client.new(api_key: "my-api-key") }

    context "specifying parameter" do
      it "returns false if the parameter is an empty string" do
        expect(client.valid_api_key?("")).to eq(false)
      end

      it "returns false if the API call to WaniKani returns an unsuccessful response" do
        stub_request(:get, "https://www.wanikani.com/api/#{client.api_version}/user/invalid-api-key/user-information").
           to_return(body: File.new("spec/fixtures/error.json"), status: 401, headers: { "Content-Type" => "application/json" })
        expect(client.valid_api_key?("invalid-api-key")).to eq(false)
      end

      it "returns false if the API call to WaniKani returns an error key" do
        stub_request(:get, "https://www.wanikani.com/api/#{client.api_version}/user/invalid-api-key/user-information").
           to_return(body: File.new("spec/fixtures/error.json"), headers: { "Content-Type" => "application/json" })
        expect(client.valid_api_key?("invalid-api-key")).to eq(false)
      end

      it "returns true if the API call to WaniKani is valid" do
        stub_request(:get, "https://www.wanikani.com/api/#{client.api_version}/user/valid-api-key/user-information").
           to_return(body: File.new("spec/fixtures/user-information.json"), headers: { "Content-Type" => "application/json" })
        expect(client.valid_api_key?("valid-api-key")).to eq(true)
      end

      it "uses the client's specified API key if the parameter is nil" do
        stub_request(:get, "https://www.wanikani.com/api/#{client.api_version}/user/#{client.api_key}/user-information").
          to_return(body: File.new("spec/fixtures/user-information.json"), headers: { "Content-Type" => "application/json" })
        expect(client.valid_api_key?(nil)).to eq(true)
      end
    end

    context "without specifying parameter" do
      it "returns false if the API call to WaniKani returns an unsuccessful response" do
        stub_request(:get, "https://www.wanikani.com/api/#{client.api_version}/user/#{client.api_key}/user-information").
           to_return(body: File.new("spec/fixtures/error.json"), status: 401, headers: { "Content-Type" => "application/json" })
        expect(client.valid_api_key?).to eq(false)
      end

      it "returns false if the API call to WaniKani returns an error key" do
        stub_request(:get, "https://www.wanikani.com/api/#{client.api_version}/user/#{client.api_key}/user-information").
           to_return(body: File.new("spec/fixtures/error.json"), headers: { "Content-Type" => "application/json" })
        expect(client.valid_api_key?).to eq(false)
      end

      it "returns true if the API call to WaniKani is valid" do
        stub_request(:get, "https://www.wanikani.com/api/#{client.api_version}/user/#{client.api_key}/user-information").
           to_return(body: File.new("spec/fixtures/user-information.json"), headers: { "Content-Type" => "application/json"  })
        expect(client.valid_api_key?).to eq(true)
      end
    end
  end

  describe ".valid_api_key?" do
    context "specifying parameter" do
      it "raises an ArgumentError if the API key is not set" do
        expect {
          Wanikani::Client.valid_api_key?
        }.to raise_error(ArgumentError, "You must specify a WaniKani API key before querying the API.")
      end

      it "raises an ArgumentError if the API key is blank" do
        expect {
          Wanikani::Client.valid_api_key?("")
        }.to raise_error(ArgumentError, "You must specify a WaniKani API key before querying the API.")
      end

      it "returns false if the API call to WaniKani returns an unsuccessful response" do
        stub_request(:get, "https://www.wanikani.com/api/#{Wanikani::DEFAULT_API_VERSION}/user/invalid-api-key/user-information").
           to_return(body: File.new("spec/fixtures/error.json"), status: 401, headers: { "Content-Type" => "application/json" })
        expect(Wanikani::Client.valid_api_key?("invalid-api-key")).to eq(false)
      end

      it "returns false if the API call to WaniKani returns an error key" do
        stub_request(:get, "https://www.wanikani.com/api/#{Wanikani::DEFAULT_API_VERSION}/user/invalid-api-key/user-information").
           to_return(body: File.new("spec/fixtures/error.json"), headers: { "Content-Type" => "application/json" })
        expect(Wanikani::Client.valid_api_key?("invalid-api-key")).to eq(false)
      end

      it "returns true if the API call to WaniKani is valid" do
        stub_request(:get, "https://www.wanikani.com/api/#{Wanikani::DEFAULT_API_VERSION}/user/valid-api-key/user-information").
           to_return(body: File.new("spec/fixtures/user-information.json"), headers: { "Content-Type" => "application/json" })
        expect(Wanikani::Client.valid_api_key?("valid-api-key")).to eq(true)
      end
    end
  end
end
