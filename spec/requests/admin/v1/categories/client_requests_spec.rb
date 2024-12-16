require 'rails_helper'

RSpec.describe "Admin V1 Categories as :client", type: :request do
  # cria usuário que seja do tipo cliente, que é de quem pegamos o cabeçalho de autenticação.
  let(:user) { create(:user, profile: :client) }

  context "GET /categories" do
    before(:each) { get url, headers: auth_header(user) }
    let(:url) { "/admin/v1/categories" }
    let!(:categories) { create_list(:category, 5) }
    include_examples "forbidden access"
  end

  context "POST /categories" do
    before(:each) { post url, headers: auth_header(user) }
    let(:url) { "/admin/v1/categories" }
    include_examples "forbidden access"
  end

  context "PATCH /categories/:id" do
    before(:each) { patch url, headers: auth_header(user) }
    let(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }
    include_examples "forbidden access"
  end

  context "DELETE /categories/:id" do
    before(:each) { delete url, headers: auth_header(user) }
    let!(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }
    include_examples "forbidden access"
  end
end
