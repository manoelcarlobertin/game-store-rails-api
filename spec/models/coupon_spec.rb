require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { is_expected.to validate_presence_of :code }
  it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
  it { is_expected.to validate_presence_of :status }
  it { is_expected.to define_enum_for(:status).with_values({ active: 1, inactive: 2 }) }
  it { is_expected.to validate_presence_of :discount_value }
  it { is_expected.to validate_numericality_of(:discount_value).is_greater_than(0) }
  it { is_expected.to validate_presence_of :due_date }

  it_behaves_like "name searchable concern", :coupon
  it_behaves_like "paginatable concern", :coupon

  # a variável due_date precisa ser definida antes de ser usada.
  let(:due_date) { Date.today } # Defina um valor padrão para due_date

  subject { described_class.new(due_date: due_date) }

  context 'when due_date is in the past' do
    let(:due_date) { Date.yesterday }

    it 'is not valid' do
      expect(subject).not_to be_valid
      expect(subject.errors[:due_date]).not_to be_empty
    end
  end

  let(:due_date) { Date.tomorrow } # Data válida para o teste

  subject { described_class.new(code: 'COUPON123', status: :active, discount_value: 10, due_date: due_date) }
  # Garantir acima que todas as validações de presença e numéricas sejam atendidas.

  context 'when due_date is in the future' do
    it 'is valid' do
      expect(subject).to be_valid
      expect(subject.errors[:due_date]).to be_empty
    end
  end
end
