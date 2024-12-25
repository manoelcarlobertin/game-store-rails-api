RSpec.shared_examples 'paginatable concern' do
  describe '#paginate' do
    let(:page) { 1 }
    let(:length) { 10 }

    subject { described_class.paginate(page: page, length: length) }

    it 'paginates records with given page and length' do
      expect(described_class).to receive(:limit).with(length).and_call_original
      expect(described_class).to receive(:offset).with((page - 1) * length).and_call_original
      subject
    end

    context 'when page is nil' do
      let(:page) { nil }

      it 'uses default page 1' do
        expect(described_class).to receive(:limit).with(length).and_call_original
        expect(described_class).to receive(:offset).with(0).and_call_original
        subject
      end
    end

    context 'when length is nil' do
      let(:length) { nil }

      it 'uses default length 10' do
        expect(described_class).to receive(:limit).with(10).and_call_original
        expect(described_class).to receive(:offset).with(0).and_call_original
        subject
      end
    end
  end
end
