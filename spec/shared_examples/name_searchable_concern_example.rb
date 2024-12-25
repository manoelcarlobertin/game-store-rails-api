# recebe nome da factory do model p que internamente possa criar dados/validar
RSpec.shared_examples 'name searchable concern' do |factory_name|
  # let(:records_list) { described_class.all } <= exemplo da IA

  let!(:search_param) { "Example" } # variável de busca

  let!(:records_to_find) do
    (0..3).to_a.map { |index| create(factory_name, name: "Example #{index}") }
  end

  let!(:records_to_ignore) { create_list(factory_name, 3) }

  # validar o 1º teste, começando pelo de registros encontrados.
  it "found records with expression in :name" do
    found_records = described_class.search_by_name(search_param)
    expect(found_records.to_a).to contain_exactly(*records_to_find)
  end

  # validar o 2º teste, NÃO retorna o que não queremos!
  it "ignores records without expression in :name" do
    found_records = described_class.search_by_name(search_param)
    expect(found_records.to_a).to_not include(*records_to_ignore)
  end
end
