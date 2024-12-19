require "rails_helper"

class Validatable
  include ActiveModel::Validations
  attr_accessor :date
  validates :date, future_date: true
end

# teste do validator utilizando a classe **Validatable** que criamos como **subject** do nosso teste
# e desta forma o *subject* do **RSpec** vai ser a instância da classe que a gente criou lá em cima

RSpec.describe FutureDateValidator do
  subject { Validatable.new }

  let(:current_date) { Date.today }

  context "when date is before current date" do
    before { subject.date = 1.day.ago }

    it "should be invalid (se o model é inválido)" do
      expect(subject.valid?).to be_falsey
    end

    it "adds an error on model (se o model possui o campo *date* nos erros)" do
      subject.valid?
      expect(subject.errors.messages.keys).to include(:date)
    end
  end

  context "when date is equal current date" do
    before { subject.date = Time.zone.now }

    it "should be invalid (o model precisa ser inválido)" do
      expect(subject.valid?).to be_falsey
    end

    it "adds an error on model (o model precisa ter o campo *date* nos erros)" do
      subject.valid?
      expect(subject.errors.messages.keys).to include(:date)
    end
  end

  context "when date is greater than current date" do
    before { subject.date = Time.zone.now + 1.day }

    it "should be valid (o nosso model tem que ver válido.)" do
      expect(subject.valid?).to be_truthy
    end
  end
end
