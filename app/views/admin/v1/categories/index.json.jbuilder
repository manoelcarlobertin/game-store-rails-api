json.categories do
  json.array! @loading_service.records, :id, :name
end
# o *json.array!*, que pega um objeto e monta um array extraíndo os atributos que passamos como parâmetro.

json.meta do
  json.partial! "shared/pagination", pagination: @loading_service.pagination
end
# Estamos chamando a *partial* dentro de um item *meta*, isso fará com o que o JSON fique na seguinte estrutura

# ```json
# {
#    ...,
#    "meta": {
#      "page": 1,
#      "length": 10,
#      "total": 20,
#      "total_pages": 2
#    }
# }
