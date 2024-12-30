<<<<<<< HEAD
RSpec.shared_examples "paginatable concern" do
  let!(:records) { create_list(:category, 20) }

  it "paginates records with given page and length" do
    paginated_records = described_class.paginate(2, 5)
    expect(paginated_records.length).to eq(5)
    expect(paginated_records.first).to eq(records[5])
=======
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
>>>>>>> 6ad46b8826e08838da68a791b6bfbe391807d51c
  end
end
