module SimpleErrorRenderable
  extend ActiveSupport::Concern # observação no rodapé

  included do
    class_attribute :simple_error_partial

    # Aqui vem a parte interessante, estamos declarando o *render_error* com a mesma assinatura
    # do que já existe em **ApiController**, porém aqui ele vai renderizar a partial
    # que está na variável *simple_error_partial* e enviando pra ela as variáveis locais:
    # *fields* e *message*.

    # Renderiza uma partial de erro com as variáveis locais fornecidas.
    def render_error(message: nil, fields: nil, status: :unprocessable_entity)
      unless self.class.simple_error_partial
        raise "simple_error_partial not set for #{self.class.name}"
      end

      render partial: self.class.simple_error_partial,
             locals: { message: message, fields: fields }, status: status
    # tratamento de erro para o caso de a partial não ser encontrada
    rescue ActionView::MissingTemplate => e
      render json: { errors: "Error rendering partial: #{e.message}" }, status: :internal_server_error
    end
  end
end
# Uso de ActiveSupport::Concern: A utilização de ActiveSupport::Concern é uma boa prática
# para criar módulos que podem ser incluídos em classes, permitindo a adição de métodos
# e callbacks de forma limpa. (observação do rodapé)
