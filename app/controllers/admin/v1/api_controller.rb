module Admin::V1
  class ApiController < ApplicationController
    class ForbiddenAccess < StandardError; end

      include Authenticatable

      # Aqui estamos importando o concern que rendereza os erros
      include SimpleErrorRenderable
      self.simple_error_partial = "shared/simple_error"

      rescue_from ForbiddenAccess do
        render_error(message: "Forbidden access", status: :forbidden)
      end # verifique se usuário tem esse perfil e caso não, lance a exceção **ForbidenAccess**

      before_action :restrict_access_for_admin! # callback verificador se perfil admin

      private
      # agora temos o acesso restrito apenas ao usuário **:admin**.
      def restrict_access_for_admin!
        raise ForbiddenAccess unless current_user.admin?
      end
  end
end
