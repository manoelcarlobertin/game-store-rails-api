require 'rails_helper'

RSpec.describe 'Admin::V1::Home', type: :request do
  let(:user) { create(:user) }
  let(:auth_token) { JwtService.encode(user_id: user.id) }

  describe 'GET /admin/v1/home' do
    context 'quando o token é válido' do
      it 'retorna uma mensagem de sucesso' do
        get '/admin/v1/home', headers: { 'Authorization' => "Bearer #{auth_token}" }

        expect(response).to have_http_status(:success)
        expect(response.body).to include('Uhul!')
      end
    end

    context 'quando o token é inválido' do
      it 'retorna status de não autorizado' do
        get '/admin/v1/home', headers: { 'Authorization' => 'Bearer invalid_token' }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'quando o token está ausente' do
      it 'retorna status de não autorizado' do
        get '/admin/v1/home'

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
