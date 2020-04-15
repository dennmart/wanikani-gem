# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::LevelProgression do
  describe '#find_by' do
    let(:endpoint) { 'https://api.wanikani.com/v2/level_progressions' }
    let(:subjects_response) { File.new('spec/fixtures/level_progressions.json') }

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
        expect(subject.find_by.total_count).to eq(42)
      end
    end
  end

  describe '#find' do
    let(:id) { 49392 }
    let(:endpoint) { "https://api.wanikani.com/v2/level_progressions/#{id}" }
    let(:kanji_response) { File.new('spec/fixtures/level_progression.json') }

    before do
      stub_request(:get, endpoint).to_return(body: kanji_response,
                                             headers: headers)
    end

    context 'without attributes' do
      it 'returns level_progression response' do
        response = subject.find(id)
        expect(response).to be_a Wanikani::Response
        expect(response.object).to eq('level_progression')
      end
    end
  end

end
