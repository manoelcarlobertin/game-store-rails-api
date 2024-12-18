require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { is_expected.to validate_presence_of :code }
  it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
  it { is_expected.to validate_presence_of :status }
  it { is_expected.to define_enum_for(:status).with_values({ active: 1, inactive: 2 }) }
  it { is_expected.to validate_presence_of :discount_value }
  it { is_expected.to validate_numericality_of(:discount_value).is_greater_than(0) }
  it { is_expected.to validate_presence_of :due_date }

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

  context 'when due_date is in the future' do
    let(:due_date) { Date.tomorrow }

    it 'is valid' do
      expect(subject).to be_valid
      expect(subject.errors[:due_date]).to be_empty
    end
  end
end
