RSpec.shared_examples "paginatable concern" do
  let!(:records) { create_list(:category, 20) }

  it "paginates records with given page and length" do
    paginated_records = described_class.paginate(2, 5)
    expect(paginated_records.length).to eq(5)
    expect(paginated_records.first).to eq(records[5])
  end
end
