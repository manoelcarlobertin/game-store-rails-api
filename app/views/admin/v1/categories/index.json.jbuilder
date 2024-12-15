json.categories do
  json.array! @categories, :id, :name
end

# o *json.array!*, que pega um objeto e monta um array extraíndo os atributos que passamos como parâmetro.
