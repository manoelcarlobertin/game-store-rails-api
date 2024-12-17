json.errors do
  json.fields fields if defined?(fields) && fields.present?
  json.message message if defined?(message) && message.present?
end
# Exatamente como as outras renderizações de erro,
# estamos criando a chave *errors* e dentro dela uma chave *fields*,
# que é criada apenas se a variável *fields* existir
# e tiver algum conteúdo, e uma *message*, que também só é criada
# se a variável *message* existir e tiver algum conteúdo.
