# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::Summary do

  before do
    Wanikani.configure do |config|
      config.api_key = "my-api-key"
      config.api_version = "v2"
    end
  end

  let(:endpoint) { 'https://api.wanikani.com/v2/subjects' }
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

  describe '#fetch' do
    let(:id) { 1701 }
    let(:endpoint) { "https://api.wanikani.com/v2/summary" }
    let(:summary_response) { File.new('spec/fixtures/api_v2/summary.json') }

    before do
      stub_request(:get, endpoint).to_return(body: summary_response,
                                             headers: headers)
    end

    context 'without attributes' do
      it 'returns summary response' do
        response = subject.fetch
        expect(response).to be_a Wanikani::Response
        expect(response.object).to eq('report')
      end
    end
  end
end
