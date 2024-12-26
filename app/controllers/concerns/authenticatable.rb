module Authenticatable
  # criar módulos que podem ser incluídos em classes. Isso facilita a inclusão de callbacks
  extend ActiveSupport::Concern #  e métodos de instância. (ActiveSupport::Concern)

  included do
    before_action :authenticate_user!
  end

  private
                        # código torna-se mais modular;
  def authenticate_user!
    token = extract_token_from_header
    return render_unauthorized("Token is missing") unless token

    @current_user = identify_user_from_token(token)
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render_unauthorized("Invalid Credentials")
  end
                                  # Separação de responsabilidades;
  def extract_token_from_header
    header = request.headers["Authorization"]
    header.split(" ").last if header.present?
  end

  def identify_user_from_token(token)
    decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base).first
    User.find(decoded_token["user_id"])
  end
                                  # os métodos menores facilitam os testes.
  def render_unauthorized(message)
    render json: { errors: message }, status: :unauthorized
  end
end
