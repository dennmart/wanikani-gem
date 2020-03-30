# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::Response do
  let(:response_data) { JSON.parse(File.read('spec/fixtures/api_v2/subjects.json')) }
  let(:response) { described_class.new(response_data) }

  %w[id object data_updated_at total_count data].each do |field|
    describe "#{field}" do
      it { expect(response.send(field)).to eql(response_data[field]) }
    end
  end

  describe '#count' do
    it { expect(response.count).to eql(response_data['pages']['per_page']) }
  end
end
