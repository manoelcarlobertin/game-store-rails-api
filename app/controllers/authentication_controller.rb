class AuthenticationController < ApplicationController
  # before_action :authorize_request, except: :login

  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      render json: { token: encode_token(user_id: @user.id) }, status: :ok
    else
      render json: { errors: "Invalid Credentials" }, status: :unauthorized
    end
  end

  def sign_up
    @user = User.new(user_params)

    if @user.save
      render json: @user.as_json(except: :password_digest), status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def encode_token(payload)
    payload[:exp] = 24.hour.from_now.to_i
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end
