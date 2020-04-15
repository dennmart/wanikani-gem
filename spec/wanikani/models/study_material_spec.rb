# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::StudyMaterial do
  describe '#find_by' do
    let(:endpoint) { 'https://api.wanikani.com/v2/study_materials' }
    let(:subjects_response) { File.new('spec/fixtures/study_materials.json') }

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
        expect(subject.find_by.total_count).to eq(88)
      end
    end
  end

  describe '#find' do
    let(:id) { 65231 }
    let(:endpoint) { "https://api.wanikani.com/v2/study_materials/#{id}" }
    let(:kanji_response) { File.new('spec/fixtures/study_material.json') }

    before do
      stub_request(:get, endpoint).to_return(body: kanji_response,
                                             headers: headers)
    end

    context 'without attributes' do
      it 'returns study_material response' do
        response = subject.find(id)
        expect(response).to be_a Wanikani::Response
        expect(response.object).to eq('study_material')
      end
    end
  end

end
