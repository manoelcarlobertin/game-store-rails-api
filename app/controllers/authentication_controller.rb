class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { token: token }, status: :ok
    else
      render json: { errors: "Invalid Credentials" }, status: :unauthorized
    end
      # Logs para depuração
      Rails.logger.info "Email: #{params[:email]}"
    # Não registre a senha
  end

  def sign_up
    @user = User.new(user_params)

    if @user.save
      render json: @user.as_json(except: :password), status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def encode_token(payload)
    payload[:exp] = 72.hour.from_now.to_i
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end
