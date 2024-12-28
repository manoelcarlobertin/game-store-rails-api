RSpec.shared_examples 'paginatable concern' do
  let(:records_per_page) { 2 }
  let(:page) { 1 }
  let(:total_pages) { (described_class.count / records_per_page.to_f).ceil }

  describe '.paginate' do
    before do
      described_class.destroy_all
      create_list(described_class.to_s.underscore.to_sym, 5)
    end

    context 'when params are valid' do
      let(:params) { { page: page, records_per_page: records_per_page } }

      it 'returns records with pagination' do
        result = described_class.paginate(params)
        expect(result.count).to eq records_per_page
      end

      it 'returns correct page' do
        result = described_class.paginate(params)
        expect(result.current_page).to eq page
      end

      it 'returns correct total pages' do
        result = described_class.paginate(params)
        expect(result.total_pages).to eq total_pages
      end
    end

    context 'when params are not present' do
      it 'returns default pagination' do
        result = described_class.paginate({})
        expect(result.count).to eq 10
        expect(result.current_page).to eq 1
      end
    end

    context 'when page param is invalid' do
      let(:params) { { page: 0, records_per_page: records_per_page } }

      it 'returns first page' do
        result = described_class.paginate(params)
        expect(result.current_page).to eq 1
      end
    end

    context 'when records_per_page param is invalid' do
      let(:params) { { page: page, records_per_page: 0 } }

      it 'returns default records per page' do
        result = described_class.paginate(params)
        expect(result.limit_value).to eq 10
      end
    end
  end
end
