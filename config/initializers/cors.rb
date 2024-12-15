Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*"
    resource "*", headers: :any, methods: [ :get, :post, :put, :patch, :delete ]
  end
end

# Nós configuramos o **RackCORS** como um middleware do Rails.
# Este *insert_before 0* está informando que estamos adicionando
# o **Rack::CORS** antes do middlware *0*, ou seja, ele vai ser o primeiro.

# Estamos configurando para aceitar requisições de qualquer origem
# com o *origins \** e também que seja consumido qualquer recurso
# com qualquer cabeçalho desde que sejam os métodos HTTP:
# **GET**, **POST**, **PUT**, **PATCH** ou **DELETE** com o *resource \**.

# Com essa configuração não teremos nenhum problema quando formos para o
# front, já que lá precisaremos inciar o servidor numa porta diferente do
# servidor do Rails.n
