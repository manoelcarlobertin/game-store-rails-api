require 'rails_helper'

RSpec.describe 'Admin V1 Categories', type: :request do # uso variáveis abaixo:
  let(:user) { create(:user, profile: :admin) } # Certifique-se de que você tenha uma factory para criar um usuário admin
  let(:category_params) { { name: 'New Category' } } # Defina os parâmetros válidos para a categoria
  let(:url) { '/admin/v1/categories' } # Defina a URL correta para a requisição

  describe 'POST /categories' do
    context 'with valid params' do
      # let(:category_params) { { category: attributes_for(:category) }.to_json }
      it 'adds a new Category' do
        post url, headers: auth_header(user), params: category_params

        expect(response).to have_http_status(:created)
        # expect do
        # end.to change(Category, :count).by(1)
      end

      it 'returns last added Category' do
        post url, headers: auth_header(user), params: category_params
        expected_category = Category.last.as_json(only: %i[id name])
        expect(body_json['category']).to eq expected_category
      end

      it 'returns success status' do
        post url, headers: auth_header(user), params: category_params
        expect(response).to have_http_status(:created)
        # após a criação de uma categoria (201 Created)
      end
    end

    context "with invalid params" do
      let(:category_invalid_params) do
        { category: attributes_for(:category, name: nil) }.to_json
      end

      it 'does not add a new Category' do
        expect do
          post url, headers: auth_header(user), params: category_invalid_params
        end.to_not change(Category, :count)
      end

      it 'returns error message' do
        post url, headers: auth_header(user), params: category_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it 'returns unprocessable_entity status' do
        post url, headers: auth_header(user), params: category_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

    context 'PATCH /categories/:id' do
    let!(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }
    let(:updated_params) { { name: 'Updated Category' } }

    it 'updates the Category' do
      patch url, headers: auth_header(user), params: updated_params
      category.reload
      expect(category.name).to eq('Updated Category')
    end

    it 'returns success status' do
      patch url, headers: auth_header(user), params: updated_params
      expect(response).to have_http_status(:ok)
    end
  end


  context "DELETE /categories/:id" do
    let!(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }

    it 'removes Category' do
      expect do
        delete url, headers: auth_header(user)
      end.to change(Category, :count).by(-1)
    end

    it 'returns success status' do
      delete url, headers: auth_header(user)
      expect(response).to have_http_status(:no_content)
    end

    it 'does not return any body content' do
      delete url, headers: auth_header(user)
      expect(body_json).to_not be_present
    end

    it 'removes all associated product categories' do
      product_categories = create_list(:product_category, 3, category: category)
      delete url, headers: auth_header(user)
      expected_product_categories = ProductCategory.where(id: product_categories.map(&:id))
      expect(expected_product_categories.count).to eq 0
    end

    it 'does not remove unassociated product categories' do
      product_categories = create_list(:product_category, 3)
      delete url, headers: auth_header(user)
      present_product_categories_ids = product_categories.map(&:id)
      expected_product_categories = ProductCategory.where(id: present_product_categories_ids)
      expect(expected_product_categories.ids).to contain_exactly(*present_product_categories_ids)
    end
  end
end
