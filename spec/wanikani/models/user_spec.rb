# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::User do
  describe '#fetch' do
    let(:id) { 1701 }
    let(:endpoint) { "https://api.wanikani.com/v2/user" }
    let(:user_response) { File.new('spec/fixtures/api_v2/user.json') }

    before do
      stub_request(:get, endpoint).to_return(body: user_response,
                                             headers: headers)
    end

    context 'without attributes' do
      it 'returns user response' do
        response = subject.fetch
        expect(response).to be_a Wanikani::Response
        expect(response.object).to eq('user')
      end
    end
  end
end
