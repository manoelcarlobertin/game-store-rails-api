require "rails_helper"
# teste para a rota da home
describe "Home", type: :request do
  let(:user) { create(:user) }

  before do
      get '/admin/v1/home', headers: auth_header(user)
  end

  # Verificando tanto o corpo da resposta (body_json)
  it "returns a success message 'Uhul!'" do
    expect(body_json).to eq({ 'message' => 'Uhul!' })
  end

  it "returns HTTP status ok (200)" do
    expect(response).to have_http_status(:ok)
  end

  context "when user is not authenticated" do
    before do
      get '/admin/v1/home' # Sem headers
    end

    it "returns HTTP status unauthorized (401)" do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
