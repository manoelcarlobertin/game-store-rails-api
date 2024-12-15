context "POST /categories" do
  let(:url) { "/admin/v1/categories" }

  context "with valid params" do
    let(:category_params) { { category: attributes_for(:category) }.to_json }

    it 'adds a new Category' do
      expect do
        post url, headers: auth_header(user), params: category_params
      end.to change(Category, :count).by(1)
    end

    it 'returns last added Category' do
      post url, headers: auth_header(user), params: category_params
      expected_category = Category.last.as_json(only: %i(id name))
      expect(body_json['category']).to eq expected_category
    end

    it 'returns success status' do
      post url, headers: auth_header(user), params: category_params
      expect(response).to have_http_status(:ok)
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
