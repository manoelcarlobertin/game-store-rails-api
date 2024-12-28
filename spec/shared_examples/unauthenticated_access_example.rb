# pra os exemplos não-autenticados, vamos apenas validar se está retornando o status *401* (**:unauthenticated**)
RSpec.describe "Admin V1 Categories without authentication", type: :request do
  shared_examples "unauthenticated access" do
    it "returns unauthorized status 401" do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
