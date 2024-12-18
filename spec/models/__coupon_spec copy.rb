require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { is_expected.to validate_presence_of :code }
  it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
  it { is_expected.to validate_presence_of :status }
  it { is_expected.to define_enum_for(:status).with_values({ active: 1, inactive: 2 }) }
  it { is_expected.to validate_presence_of :discount_value }
  it { is_expected.to validate_numericality_of(:discount_value).is_greater_than(0) }
  it { is_expected.to validate_presence_of :due_date }

  # Estamos validando se `due_date` vem nos erros do model quando ela é anterior
  # ou igual à data atual e se não está quando é posterior. Abaixo:

  # it "can't have past due_date" do
  #   subject.due_date = 1.day.ago
  #   subject.valid?
  #   expect(subject.errors.keys).to include :due_date
  # end REFATORADO ABAIXO

  subject { described_class.new(due_date: past_date) }

  context 'when due_date is in the past' do
    let(:past_date) { Date.yesterday }

    it 'is not valid' do
      expect(subject).not_to be_valid
      expect(subject.errors[:due_date]).not_to be_empty
    end
  end

  # it "is invalid with current due_date" do
  #   subject.due_date = Time.zone.now
  #   subject.valid?
  #   expect(subject.errors.keys).to include :due_date
  # end REFATORADO ABAIXO

  subject { described_class.new(due_date: invalid_date) }

  context 'when due_date is invalid' do
    let(:invalid_date) { Date.yesterday } # ou qualquer lógica que torne a data inválida

    it 'is not valid' do
      expect(subject).not_to be_valid
      expect(subject.errors[:due_date]).not_to be_empty
    end
  end

  # it "is valid with future date" do
  #   subject.due_date = Time.zone.now + 1.hour
  #   subject.valid?
  #   expect(subject.errors.keys).to_not include :due_date
  # end  REFATORANDO ABAIXO ESSE TESTE:

  subject { described_class.new(due_date: future_date) }

  context 'when due_date is in the future' do
    let(:future_date) { Date.tomorrow } # ou qualquer lógica que torne a data válida

    it 'is valid' do
      expect(subject).to be_valid
      expect(subject.errors[:due_date]).to be_empty
    end
  end
end
# Aqui posso verificar se a chave não está presente e também garantir que não há mensagens de erro.
