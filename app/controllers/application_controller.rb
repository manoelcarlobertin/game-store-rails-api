class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
  # Adicionar um método de autenticação JWT
  before_action :authenticate_user!

  private

  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last
    Rails.logger.info "Token recebido: #{token}"
    unless JwtService.decode(token)
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
    payload = JwtService.decode(token)

    if payload.nil?
      render json: { error: "Unauthorized" }, status: :unauthorized
    else
      @current_user = User.find(payload["user_id"])
    end
  rescue Jwt::DecodeError => e
  Rails.logger.error "Erro ao decodificar token: #{e.message}"
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
# Abaixo o método de autenticação é Devise:
# class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
#   before_action :configure_permitted_parameters, if: :devise_controller?

#   def not_found
#     render json: { error: "not_found" }
#   end

#   def authorize_request
#     header = request.headers["Authorization"]
#     header = header.split(" ").last if header
#     begin
#       @decoded = JsonWebToken.decode(header)
#       @current_user = User.find(@decoded[:user_id])
#     rescue ActiveRecord::RecordNotFound => e
#       render json: { errors: e.message }, status: :unauthorized
#     rescue JWT::DecodeError => e
#       render json: { errors: e.message }, status: :unauthorized
#     end
#   end

#   protected

#   def configure_permitted_parameters
#     devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :password, :password_confirmation ])
#   end
# end
