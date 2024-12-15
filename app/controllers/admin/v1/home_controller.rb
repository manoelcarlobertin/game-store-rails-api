module Admin::V1
  class HomeController < ApiController
    def index
      render json: { message: "Uhul!" }
    end
  end
end
# Perceba que criamos o controllher herdando de **ApiController**,
# ou seja, o usuário deve ser autenticado.
