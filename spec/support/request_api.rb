# modulo para auxiliar o retorno dos HEADERS de autenticação abaixo:
module RequestAPI
  def body_json(symbolize_keys: false)
    json = JSON.parse(response.body)
    symbolize_keys ? json.deep_symbolize_keys : json
  rescue
    {} # return, pra não ficar redundante
  end

  def auth_header(user = nil, merge_with: {})
    user ||= create(:user)
    token = user.generate_jwt # método correto p gerar o token
    header = { 'Authorization' => "Bearer #{token}" }
    header.merge({ 'Content-Type' => 'application/json', 'Accept' => 'application/json' }).merge(merge_with)
  end

  def unauthenticated_header(merge_with: {})
    default_header = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    default_header.merge merge_with
  end
end
# incluir este módulo dentro do **RSpec**.
RSpec.configure do |config|
  config.include RequestAPI, type: :request
end

# Neste arquivo de suporte teremos 2 métodos:
# um para fazer o *parse* das respostas que chegam em JSON para hash
# e outro para retornar o cabeçalho de autenticação de um usuário.
# Então vamos começar acrescendo o método para o *parse*
