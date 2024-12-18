class ApplicationController < ActionController::API
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def not_found
    render json: { error: "not_found" }
  end

  def authorize_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :password, :password_confirmation ])
  end
end
# Este método `devise_parameter_sanitizer.permit` é padrão do **Devise**
# e com eles conseguimos confirmar os parâmetros para o **Sign Up**
