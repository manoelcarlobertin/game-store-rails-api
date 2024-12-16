shared_examples "forbidden access" do
  it "returns error message" do
    expect(body_json['errors']['message']).to eq "Forbidden access"
  end
  # se o acesso probido e outra para verificar se o status é *403*
  it "returns forbidden status" do
    expect(response).to have_http_status(:forbidden)
  end
end
