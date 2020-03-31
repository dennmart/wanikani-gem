# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::Subject do
  describe '#find_by' do
    let(:endpoint) { 'https://api.wanikani.com/v2/subjects' }
    let(:subjects_response) { File.new('spec/fixtures/api_v2/subjects.json') }

    before(:each) do
      stub_request(:get, endpoint).to_return(body: subjects_response,
                                             headers: headers)
    end

    context 'without attributes' do
      it 'returns collection response' do
        response = subject.find_by
        expect(response).to be_a Wanikani::Response
        expect(response.object).to eq('collection')
      end

      it 'returns expected total_count' do
        expect(subject.find_by.total_count).to eq(2027)
      end
    end
  end

  describe '#find' do
    let(:id) { 1701 }
    let(:endpoint) { "https://api.wanikani.com/v2/subjects/#{id}" }
    let(:kanji_response) { File.new('spec/fixtures/api_v2/kanji.json') }

    before do
      stub_request(:get, endpoint).to_return(body: kanji_response,
                                             headers: headers)
    end

    context 'without attributes' do
      it 'returns kanji response' do
        response = subject.find(id)
        expect(response).to be_a Wanikani::Response
        expect(response.object).to eq('kanji')
      end

      it 'returns collection response' do
        response = subject.find(id)
        expect(response).to be_a Wanikani::Response
        expect(response.object).to eq('kanji')
      end
    end
  end

end
