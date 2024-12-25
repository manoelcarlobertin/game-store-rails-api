require 'rails_helper'

# O **validate_uniqueness_of** também é um matcher do **Shoulda Matchers**
# Ele é capaz de validar se um atributo está sendo validado para ser único.
# Este matcher ainda tem a capacidade de verificar se a validação é case insensitive, como fizemos agora
RSpec.describe Category, type: :model do
  # É a mesma coisa abaixo:           it { expect(subject).to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

  it { is_expected.to have_many(:product_categories).dependent(:destroy) }
  it { is_expected.to have_many(:products).through(:product_categories) }

  # incluí aqui shared example no model Category
  # aqui chama o concern e passa como parâmetro nome da factory
  it_behaves_like "name searchable concern", :category
end
# quando Category por remova, todos registros ProductCategory associados a ela também serão.
# Também estamos add uma associação has_many direto com Product através da associação com ProductCategory
