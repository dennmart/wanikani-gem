# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::Summary do
  describe '#fetch' do
    let(:id) { 1701 }
    let(:endpoint) { "https://api.wanikani.com/v2/summary" }
    let(:summary_response) { File.new('spec/fixtures/summary.json') }

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
