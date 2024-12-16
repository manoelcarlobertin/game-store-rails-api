require 'rails_helper'

RSpec.describe "Admin V1 Categories as :client", type: :request do
  context "GET /categories" do
    before(:each) { get url }
    let(:url) { "/admin/v1/categories" }
    let!(:categories) { create_list(:category, 5) }
    # include_examples "unauthenticated access"
  end

  context "POST /categories" do
    before(:each) { post url }
    let(:url) { "/admin/v1/categories" }
    # include_examples "unauthenticated access"
  end

  context "PATCH /categories/:id" do
    before(:each) { patch url }
    let(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }
    # include_examples "unauthenticated access"
  end

  context "DELETE /categories/:id" do
    before(:each) { delete url }
    let!(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }
    # include_examples "unauthenticated access"
  end
end
