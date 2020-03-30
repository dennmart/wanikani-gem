# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::ApiV2::User do
  let(:client) { Wanikani::ApiV2::Client.new(api_key: "my-api-key") }
  let(:endpoint) { 'https://api.wanikani.com/v2/user' }
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

  describe "#user_information" do
    before(:each) do
      stub_request(:get, endpoint).to_return(body: user_response,
                                             headers: headers)
    end

    it "returns a hash with the Wanikani account information" do
      user_info = client.user_information
      expect(user_info).to be_a(Hash)

      expect(user_info["username"]).to eq("crabigator")
      expect(user_info["level"]).to eq(25)
      expect(user_info["profile_url"]).to eq('https://www.wanikani.com/users/crabigator')
      expect(user_info["started_at"]).to eq('2012-05-11T00:52:18.958466Z')
    end
  end

  describe "#on_vacation?" do
    it "returns false if the vacation_date field is null" do
      stub_request(:get, endpoint).to_return(body: user_response,
                                             headers: headers)

      expect(client.on_vacation?).to eq(false)
    end

    it "returns true if the vacation_date field is not null" do
      stub_request(:get, endpoint).to_return(body: File.new("spec/fixtures/api_v2/user-on-vacation.json"),
                                             headers: headers)

      expect(client.on_vacation?).to eq(true)
    end
  end

  describe ".full_user_response" do
    it "returns the full response with the user_information and requested_information keys" do
      stub_request(:get, endpoint).to_return(body: user_response,
                                             headers: headers)

      full_response = client.full_user_response
      expect(full_response).to have_key("data")
    end
  end
end
