module Admin::V1
  class AuthenticationController < ApiController
    SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

    def login
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        token = jwt_encode(user_id: user.id)
        render json: { token: token }, status: :ok
      else
        render json: { errors: [ "Credenciais inválidas" ] }, status: :unauthorized
      end
    end

    private

    def jwt_encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end
  end
end
