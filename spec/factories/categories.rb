# Com o **sequence**, cada vez que a *factory* for chamada dentro de um teste,
# o `n` vai receber um valor diferente. Ou seja, se criarmos duas categorias com ela,
# ele criará com o nome **Category 1** e **Category 2**, sequencialmente. Expressão regular: Regex
FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
  end
end
