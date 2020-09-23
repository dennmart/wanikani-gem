# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::ReviewStatistic do
  describe '#find_by' do
    let(:endpoint) { 'https://api.wanikani.com/v2/review_statistics' }
    let(:subjects_response) { File.new('spec/fixtures/review_statistics.json') }

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
        expect(subject.find_by.total_count).to eq(980)
      end
    end
  end

  describe '#find' do
    let(:id) { 80461982 }
    let(:endpoint) { "https://api.wanikani.com/v2/review_statistics/#{id}" }
    let(:kanji_response) { File.new('spec/fixtures/review_statistic.json') }

    before do
      stub_request(:get, endpoint).to_return(body: kanji_response,
                                             headers: headers)
    end

    context 'without attributes' do
      it 'returns review_statistic response' do
        response = subject.find(id)
        expect(response).to be_a Wanikani::Response
        expect(response.object).to eq('review_statistic')
      end
    end
  end

end
