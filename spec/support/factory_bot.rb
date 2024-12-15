# Junto com o RSpec, nós utilizatemos outras 3 ferramentas para suporte:
# o Factory Bot junto com o Faker configurarmos dados de teste;

# Estamos utilizando o método `configure` do **RSpec** para incluir
# o módulo **FactoryBot::Syntax::Methods** do **Factory Bot**
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
