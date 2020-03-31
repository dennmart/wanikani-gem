# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::StudyMaterial do
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


  before do
    Wanikani.configure do |config|
      config.api_key = "my-api-key"
      config.api_version = "v2"
    end
  end

  describe '#find_by' do
    let(:endpoint) { 'https://api.wanikani.com/v2/study_materials' }
    let(:subjects_response) { File.new('spec/fixtures/api_v2/study_materials.json') }

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
    let(:kanji_response) { File.new('spec/fixtures/api_v2/study_material.json') }

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
