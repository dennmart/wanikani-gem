# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::VoiceActor do
  describe '#find_by' do
    let(:endpoint) { 'https://api.wanikani.com/v2/voice_actors' }
    let(:voice_actors_response) { File.new('spec/fixtures/voice_actors.json') }

    before(:each) do
      stub_request(:get, endpoint).to_return(body: voice_actors_response,
                                             headers: headers)
    end

    context 'without attributes' do
      it 'returns collection response' do
        response = subject.find_by
        expect(response).to be_a Wanikani::Response
        expect(response.object).to eq('collection')
      end

      it 'returns expected total_count' do
        expect(subject.find_by.total_count).to eq(2)
      end
    end
  end

  describe '#find' do
    let(:id) { 1701 }
    let(:endpoint) { "https://api.wanikani.com/v2/voice_actors/#{id}" }
    let(:kanji_response) { File.new('spec/fixtures/voice_actor.json') }

    before do
      stub_request(:get, endpoint).to_return(body: kanji_response,
                                             headers: headers)
    end

    context 'without attributes' do
      it 'returns voice_actor response' do
        response = subject.find(id)
        expect(response).to be_a Wanikani::Response
        expect(response.object).to eq('voice_actor')
      end
    end
  end

end
