module Admin::V1
  class HomeController < ApiController
    before_action :authenticate_user!
    def index
      render json: { message: "Uhul!" }, status: :ok
    end
  end
end
# Perceba que criamos o controller herdando de **ApiController**,
# ou seja, o usuário deve ser autenticado.
