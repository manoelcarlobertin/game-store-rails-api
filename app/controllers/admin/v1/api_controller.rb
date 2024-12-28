module Admin::V1
  class ApiController < ApplicationController
    class ForbiddenAccess < StandardError; end
    SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

    before_action :authenticate_request

    rescue_from ForbiddenAccess do
      render_error(message: "Forbidden access", status: :forbidden)
    end

    before_action :restrict_access_for_admin!

    include SimpleErrorRenderable
    self.simple_error_partial = "shared/simple_error"

    def render_success(data: nil, message: nil)
      # Implementation missing
    end

    private

    def restrict_access_for_admin!
      raise ForbiddenAccess unless current_user.admin?
    end

    def authenticate_request
      header = request.headers["Authorization"]
      token = header.split(" ").last if header
      decoded = jwt_decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      render json: { errors: [ "Não autorizado" ] }, status: :unauthorized
    end

    def jwt_decode(token)
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new(decoded)
    end

    attr_reader :current_user
  end
end
