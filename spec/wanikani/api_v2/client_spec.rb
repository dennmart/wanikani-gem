# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::ApiV2::Client do
  let(:endpoint) { 'https://api.wanikani.com/v2/user/' }
  let(:headers) do
    {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization'=>'Bearer my-api-key',
      'Content-Type'=>'application/json',
      'User-Agent'=>'Faraday v0.17.3',
      'Wanikani-Revision'=>'20170710'
      }
  end
  let(:error_response) { File.new('spec/fixtures/api_v2/error.json') }
  let(:user_response) { File.new('spec/fixtures/api_v2/user.json') }

  describe "#initialize" do
    it "raises an ArgumentError if the API key is not set" do
      expect {
        described_class.new
      }.to raise_error(ArgumentError, "You must specify a WaniKani API key before querying the API.")
    end

    it "raises an ArgumentError if attempting to set an invalid API version" do
      expect {
        described_class.new(api_key: "my-api-key", api_version: "bad-api-version")
      }.to raise_error(ArgumentError, "API version should be one of the following: #{Wanikani::VALID_API_VERSIONS.join(', ')}.")
    end

    it "uses the default API version if it's not set on initialization" do
      client = described_class.new(api_key: "my-api-key")
      expect(client.api_version).to eq(Wanikani::DEFAULT_API_VERSION)
    end
  end

  describe "#valid_api_key?" do
    subject(:client) { described_class.new(api_key: "my-api-key") }

    context "specifying parameter" do
      it "returns false if the parameter is an empty string" do
        expect(client.valid_api_key?("")).to eq(false)
      end

      it "returns false if the API call to WaniKani returns an unsuccessful response" do
        stub_request(:get, endpoint).to_return(body: error_response,
                                               status: 401,
                                               headers: headers)
        expect(client.valid_api_key?("invalid-api-key")).to eq(false)
      end

      it "returns false if the API call to WaniKani returns an error key" do
        stub_request(:get, endpoint).to_return(body: error_response,
                                               headers: headers)
        expect(client.valid_api_key?("invalid-api-key")).to eq(false)
      end

      it "returns true if the API call to WaniKani is valid" do
        stub_request(:get, endpoint).to_return(body: user_response,
                                               headers: headers)
        expect(client.valid_api_key?("valid-api-key")).to eq(true)
      end

      it "uses the client's specified API key if the parameter is nil" do
        stub_request(:get, endpoint).to_return(body: user_response,
                                               headers: headers)
        expect(client.valid_api_key?(nil)).to eq(true)
      end
    end

    context "without specifying parameter" do
      context 'the API call to WaniKani returns a HTTP error' do
        it 'returns false' do
          stub_request(:get, endpoint).to_return(body: error_response,
                                                 status: 401,
                                                 headers: headers)
          expect(client.valid_api_key?).to eq(false)
        end
      end

      it "returns false if the API call to WaniKani returns an error key" do
        stub_request(:get, endpoint).to_return(body: error_response,
                                               headers: headers)
        expect(client.valid_api_key?).to eq(false)
      end

      it "returns true if the API call to WaniKani is valid" do
        stub_request(:get, endpoint).to_return(body: user_response,
                                               headers: headers)
        expect(client.valid_api_key?).to eq(true)
      end
    end
  end

  describe ".valid_api_key?" do
    context "specifying parameter" do
      it "raises an ArgumentError if the API key is not set" do
        expect {
          described_class.valid_api_key?
        }.to raise_error(ArgumentError, "You must specify a WaniKani API key before querying the API.")
      end

      context 'with blank API key' do
        it 'raises an ArgumentError' do
          expect {
            described_class.valid_api_key?("")
          }.to raise_error(ArgumentError,
                           "You must specify a WaniKani API key before querying the API.")
        end
      end

      context 'with http error' do
        it 'returns false' do
          stub_request(:get, endpoint).to_return(body: error_response,
                                                 status: 401,
                                                 headers: headers)
          expect(described_class.valid_api_key?("invalid-api-key")).to eq(false)
        end
      end

      context 'with invalid key' do
        it 'returns false' do
          stub_request(:get, endpoint).to_return(body: error_response,
                                                 headers: headers)
          expect(described_class.valid_api_key?("invalid-api-key")).to eq(false)
        end
      end

      context 'with valid API key' do
        it 'returns true' do
          stub_request(:get, endpoint).to_return(body: user_response,
                                                 headers: headers)
          expect(described_class.valid_api_key?("valid-api-key")).to eq(true)
        end
      end
    end
  end
end
